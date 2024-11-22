#!/usr/bin/python3
# -*- coding: utf-8 -*-

from argparse import ArgumentParser
import urllib.request, urllib.error, urllib.parse
import ipaddress
import base64
#import socket
#import socks
import json
import ssl
import sys
import os

#proxy = 'SOCKS5 127.0.0.1:1080; PROXY 127.0.0.1:8118;'
proxy = 'SOCKS5 192.168.18.200:1080; PROXY 192.168.18.200:8118;'
#proxy_server = 'SOCKS5 127.0.0.1:1080; PROXY 127.0.0.1:8118;'
proxy_server = 'SOCKS5 192.168.1.200:1080; PROXY 192.168.1.200:8118;'

## 本地规则匹配文件
suffix_file = os.path.join(os.path.dirname(__file__), 'local-suffix.txt')
prefix_file = os.path.join(os.path.dirname(__file__), 'local-prefix.txt')

## 国内域名列表(白名单)
#direct_file 'https://raw.githubusercontent.com/carrnot/china-domain-list/release/domain.txt'
direct_file = os.path.join(os.path.dirname(__file__), 'direct.txt')

## GFW 封禁域名列表(黑名单)
#gfwlist_file = 'https://raw.githubusercontent.com/gfwlist/gfwlist/refs/heads/master/gfwlist.txt'
gfwlist_file = os.path.join(os.path.dirname(__file__), 'gfwlist.txt')

## 国内IP地理位置列表(白名单)
#geoip_file = 'https://raw.githubusercontent.com/Loyalsoldier/geoip/refs/heads/release/text/cn.txt'
geoip_file = os.path.join(os.path.dirname(__file__), 'geoip.txt')

## PAC 文件生成模板
template_file = os.path.join(os.path.dirname(__file__), 'template.pac')

def u(s, encoding='utf-8'):
    if isinstance(s, bytes):
        return str(s, encoding)
    return str(s)

def parse_args():
    parser = ArgumentParser(prog=__file__, description='列表文件名若为URL则会自动下载')
    parser.add_argument('-p', '--proxy', dest='proxy',
                        required=False, default=proxy, metavar='PROXY',
                        help='代理服务器字符串, 多个代理之间以";"分隔, '
                        '例如: "'+ proxy + '"')
    parser.add_argument('-s', '--proxy-server', dest='proxy_server',
                        required=False, default=proxy_server, metavar='PROXY_SERVER',
                        help='代理服务器字符串, 多个代理之间以";"分隔, '
                        '例如: "'+ proxy_server + '"')

    parser.add_argument('--suffix-file', dest='suffix_file',
                        required=False, default=suffix_file, metavar=None,
                        help='本地后缀匹配规则文件, 适用于域名, 每行一个匹配条件')
    parser.add_argument('--prefix-file', dest='prefix_file',
                        required=False, default=prefix_file, metavar=None,
                        help='本地前缀匹配规则文件, 适用于IP地址, 每行一个匹配条件')

    parser.add_argument('-d', '--direct-file', dest='direct_file',
                        required=False, default=direct_file, metavar=None,
                        help='直连域名列表文件')
    parser.add_argument('-i','--gfwlist-file', dest='gfwlist_file',
                        required=False, default=gfwlist_file, metavar=None,
                        help='被墙域名列表文件')
    parser.add_argument('-c','--geoip-file', dest='geoip_file',
                        required=False, default=geoip_file, metavar=None,
                        help='所在地区IP地理位置列表文件')

    parser.add_argument('-o', '--output', dest='output',
                        required=False, default=None, metavar='PACFILE',
                        help='输出PAC内容到指定文件, 若无该参数默认输出到STDOUT')
    return parser.parse_args()

def urlopen(url, timeout=15):

    # urllib设置http代理
    #proxy = '192.168.18.200:3128'
    #proxy_handler = urllib.request.ProxyHandler({
    #    'http':'http://'+proxy,
    #    'https':'https://'+proxy,
    #    })
    #opener = urllib.request.build_opener(proxy_handler)
    #urllib.request.install_opener(opener)

    # urllib设置socks代理
    #socks.setdefaultproxy(socks.SOCK5, '192.168.18.200', '1080')
    #socket.socket = socks.socksocket

    # 请求头部的user-agent
    headers={"User-Agent" : "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36 QIHU 360SE"}
    # 请求url作为Request()方法的参数，构造并返回一个Request对象
    request=urllib.request.Request(url, headers=headers)
    #如果网站的SSL证书是经过CA认证，就需要单独处理SSL证书，让程序忽略SSL证书验证错误，即可正常访问
    context = ssl._create_unverified_context() # 忽略安全验证
    try:
        #Request对象作为urlopen()方法的参数，发送给服务器并接收响应
        #在urlopen()方法里 指明添加 context 参数
        response=urllib.request.urlopen(request, context=context, timeout=timeout)
        return response.read().decode('utf-8')
    except urllib.error.URLError as err:
        print('URL错误', err)
        return ''
    except socket.timeout as ex:
        print('请求超时', ex)
        return ''

def readfile(url):
    urlparts = urllib.parse.urlsplit(url)
    if not urlparts.scheme or not urlparts.netloc:
        # It's not an URL, deal it as local file
        with open(url, 'r') as f:
            text = f.read()
    else:
        # Yeah, it's an URL, try to download it
        print('正在下载数据列表文件: %s' % url)
        text = urlopen(url)
    return text
    #return text.splitlines(False)

def convert_cidr(cidr):
    if '/' in cidr:
        network = ipaddress.ip_network(cidr.strip(), strict=False)
        network_address = network.network_address
        prefixlen = network.prefixlen
    else:
        network = ipaddress.ip_address(cidr.strip())
        network_address = network
        prefixlen = network.max_prefixlen
    if network.version == 4:
        return hex(int(network_address))[2:] + '/' + str(prefixlen)
    else:
        return network.compressed

def parse_geoip(cidrs):
    geoip_set = set()
    for cidr in cidrs:
        geoip_set.add(convert_cidr(cidr))
    return list(geoip_set)

def decode_gfwlist(content):
    # decode base64 if have to
    try:
        if '.' in content:
            raise Exception
        return base64.b64decode(content)
    except:
        return content

def get_hostname(line):
    # quite enough for GFW
    if line.startswith('||'):
        line = line.lstrip('||')
    elif line.startswith('|'):
        line = line.lstrip('|')
    elif line.startswith('.'):
        line = line.lstrip('.')
    elif line.endswith('/'):
        line = line.rstrip('/')
    else:
        pass
    try:
        if not line.startswith('http:'):
            line = 'http://' + line
        r = urllib.parse.urlparse(line)
        return r.hostname
    except Exception as e:
        print(e)
        return None

#def add_domain_to_set(s, line):
#    hostname = get_hostname(line)
#    if hostname is not None:
#        s.add(hostname)

def combine_rules(content, rules=None):
    builtin_rules = pkgutil.get_data('gfwlist2pac', 'resources/builtin.txt').splitlines(False)
    #builtin_rules =
    gfwlist = content.splitlines(False)
    gfwlist.extend(builtin_rules)
    if rules:
        gfwlist.extend(rules.splitlines(False))
    return gfwlist

def parse_gfwlist(gfwlist):
    blacklist = set()
    for line in gfwlist:
        line = u(line)
        if line.find('.*') >= 0:
            continue
        elif line.find('*') >= 0:
            line = line.replace('*', '/')
        else:
            pass
        if line.startswith('||'):
            line = line.lstrip('||')
        elif line.startswith('|'):
            line = line.lstrip('|')
        elif line.startswith('.'):
            line = line.lstrip('.')
        elif line.startswith('@@'):
            line = line.lstrip('@@')
        elif line.startswith('!'):
            continue
        elif line.startswith('['):
            continue
        hostname = get_hostname(line)
        if hostname is None:
            continue
        blacklist.add(hostname)
    return list(blacklist)

def generate_pac(proxy, *, proxy_server, local_suffix, local_prefix, direct_list, gfwlist_host, geoip_list):
    # render the pac file
    with open(template_file, 'r') as f:
        template = f.read()
    #print(template)

    template = template.replace(
        '"__PROXY__"',
        json.dumps(str(proxy)),
        #"'{}'".format(proxy)
    )
    template = template.replace(
        '"__PROXY_SERVER__"',
        json.dumps(str(proxy_server)),
        #"'{}'".format(proxy_server)
    )

    template = template.replace(
        '"__LOCAL_SUFFIX__"',
        json.dumps(local_suffix, sort_keys=True, separators=(',',':'), indent=None),
        #"'{}'.split('|')".format('|'.join(local_rule)),
    )
    template = template.replace(
        '"__LOCAL_PREFIX__"',
        json.dumps(local_prefix, sort_keys=True, separators=(',',':'), indent=None),
        #"'{}'.split('|')".format('|'.join(local_rule)),
    )

    template = template.replace(
        '"__WHITE_LIST__"',
        json.dumps(direct_list, sort_keys=True, separators=(',',':'), indent=None),
        #"'{}'.split('|')".format('|'.join(direct_list)),
    )
    template = template.replace(
        '"__BLACK_LIST__"',
        json.dumps(gfwlist_host, sort_keys=True, separators=(',',':'), indent=None),
        #"'{}'.split('|')".format('|'.join(gfwlist_host)),
    )
    template = template.replace(
        '"__GEOIP_LIST__"',
        json.dumps(geoip_list, sort_keys=True, separators=(',',':'), indent=None),
        #"'{}'.split('|')".format('|'.join(geoip_list)),
    )

    #print(template)
    return template

def main():
    args = parse_args()

    local_suffix = []
    if args.suffix_file:
        local_suffix = readfile(args.suffix_file).splitlines(False)
        #print('本地后缀匹配规则:', local_suffix)
    #print('suffix:', len(local_suffix))

    local_prefix = []
    if args.prefix_file:
        local_prefix = readfile(args.prefix_file).splitlines(False)
        #print('本地前缀匹配规则:', local_prefix)
    #print('prefix', len(local_prefix))

    direct_list = []
    if args.direct_file:
        direct_list = readfile(args.direct_file).splitlines(False)
    #print('direct:', len(direct_list))

    gfwlist_host = []
    if args.gfwlist_file:
        content = readfile(args.gfwlist_file)
        #print('GFWList文件原始内容:\n', content)
        gfwlist_text = decode_gfwlist(content).splitlines(False)
        #print('GFWList文件解码内容:\n', gfwlist_text)
        gfwlist_host = parse_gfwlist(gfwlist_text)
    #print('gfwlist:', len(gfwlist_host))

    geoip_list = []
    if args.geoip_file:
        cidrs = readfile(args.geoip_file).splitlines(False)
        geoip_list = parse_geoip(cidrs)
    #print('geoip:', len(geoip_list))

    content = generate_pac(args.proxy, proxy_server = args.proxy_server,
                           local_suffix = local_suffix, local_prefix = local_prefix,
                           direct_list = direct_list, gfwlist_host = gfwlist_host, geoip_list = geoip_list,)

    if args.output:
        with open(args.output, 'w') as f:
            f.write(content)
    else:
        print(content, file=sys.stdout)


if __name__ == '__main__':

    main()

