const proxy = "__PROXY__";

const proxyServer = "__PROXY_SERVER__";

const direct = 'DIRECT';

// 本地域名规则
const localSuffix = "__LOCAL_SUFFIX__";

// 本地IP地址规则
const localPrefix = "__LOCAL_PREFIX__";

// 直连域名列表
const whiteList = "__WHITE_LIST__";

// 被墙域名列表
const blackList = "__BLACK_LIST__";

// GEOIP地址列表
const geoipList = "__GEOIP_LIST__";

// 是否输出调试信息
const allowAlert = false;

function debug(rule, action='N/A', msg='') {
	if (!allowAlert) {
		return
	}
	try {
		alert('[' + rule + '->' + action + '] ' + msg);
	} catch (e) {
		allowAlert = false
	}
}

function FindProxyForURL(url, host) {
	// 基于域名的连接行为
	if (isPlainHostName(host) || host === 'localhost') {
		debug('命中本地主机名', '直连', host);
		return direct;
	} else if (isInLocalSuffix(host)) {
		//debug('命中本地域名规则', '直连', host);
		//return direct;
		debug('命中本地域名规则', '代理', host);
		return proxy;
	} else if (isInWhiteList(host)) {
		debug('命中白名单', '直连', host);
		return direct;
	} else if (isInBlackList(host)) {
		debug('命中黑名单', '代理', host);
		return proxy;
	} else if (isInLocalPrefix(host)) {
		//debug('命中本地IP规则', '直连', host);
		//return direct;
		debug('命中本地IP规则', '内网代理', host);
		return proxyServer;
	} else if (isPrivateIp(host)) {
		debug('命中私有IP地址', '直连', host);
		return direct;
	}
	// 基于IP地址的连接行为
	ip = isIpAddress(host) ? host : dnsResolve(host);
	if (!ip) {
		debug('无法解析域名IP地址', '代理', host);
		return proxy;
	} else if (isPrivateIp(ip)) {
		debug('命中私有IP地址', '直连', host + '->' + ip);
		return direct;
	} else if (searchRadixTree(ipToBinary(ip))) {
		debug('匹配到直连IP地址', '直连', host + '->' + ip);
		return direct;
	}
	// 默认连接行为
	debug('未命中任何规则', '直连', host + '->' + ip);
	return direct;
	//debug('未命中任何规则', '代理', host + '->' + ip);
	//return proxy;
}

function isInLocalSuffix(host) {
	// Chrome uses .test as testing gTLD.
	var tld = host.substring(host.lastIndexOf('.'));
	if (tld === host) {
		return false;
	}
	return localSuffix.some(function(localTLD) {
		return tld === localTLD;
	});
}

function isInLocalPrefix(host) {
	for (var i = 0; i < localPrefix.length; i++) {
		var ip = localPrefix[i];
		if (host === ip || host.startsWith(ip) || host.startsWith(ip + '.')) {
			return true;
		}
	}
	return false;
}

function isInWhiteList(host) {
	for (var i = 0; i < whiteList.length; i++) {
		var domain = whiteList[i];
		if (host === domain || host.endsWith('.' + domain)) {
			return true;
		}
	}
	return false;
}

function isInBlackList(host) {
	for (var i = 0; i < blackList.length; i++) {
		var domain = blackList[i];
		if (host === domain || host.endsWith('.' + domain)) {
			return true;
		}
	}
	return false;
}

function isIpAddress(ip) {
	return /^\d{1,3}(\.\d{1,3}){3}$/.test(ip) || /^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$/.test(ip);
}

/* https://github.com/frenchbread/private-ip */
function isPrivateIp(ip) {
	return /^(::f{4}:)?10\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$/i.test(ip) ||
		/^(::f{4}:)?192\.168\.([0-9]{1,3})\.([0-9]{1,3})$/i.test(ip) ||
		/^(::f{4}:)?172\.(1[6-9]|2\d|30|31)\.([0-9]{1,3})\.([0-9]{1,3})$/i.test(ip) ||
		/^(::f{4}:)?127\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$/i.test(ip) ||
		/^(::f{4}:)?169\.254\.([0-9]{1,3})\.([0-9]{1,3})$/i.test(ip) ||
		/^f[cd][0-9a-f]{2}:/i.test(ip) ||
		/^fe80:/i.test(ip) ||
		/^::1$/.test(ip) ||
		/^::$/.test(ip);
}

function ipToBinary(ip) {
	// Check if it's IPv4
	if (/^\d{1,3}(\.\d{1,3}){3}$/.test(ip)) {
		return ip.split('.').map(function(num) {
			return ("00000000" + parseInt(num, 10).toString(2)).slice(-8);
		}).join('');
	} else if (/^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$/.test(ip)) {
		// Expand the IPv6 address if it contains '::'
		var parts = ip.split('::');
		var left = parts[0] ? parts[0].split(':') : [];
		var right = parts[1] ? parts[1].split(':') : [];

		// Calculate the number of zero groups to insert
		var zeroGroups = 8 - (left.length + right.length);

		// Create the full address by inserting zero groups
		var fullAddress = left.concat(Array(zeroGroups + 1).join('0').split('')).concat(right);

		// Convert each group to binary and pad to 16 bits
		return fullAddress.map(function(group) {
			return ("0000000000000000" + parseInt(group || '0', 16).toString(2)).slice(-16);
		}).join('');
	}
}

function RadixTree() {
	this.root = {};
}

RadixTree.prototype.insert = function(string) {
	var node = this.root;
	for (var i = 0; i < string.length; i++) {
		var char = string[i];
		if (!node[char]) {
			node[char] = {};
		}
		node = node[char];
	}
};

RadixTree.prototype.to_list = function() {
	return this.root;
};

function searchRadixTree(bits) {
	var currentNode = radixTree;
	var isLastNode = false;
	for (var i=0; i<bits.length; i++) {
		var char = bits[i];
		if (currentNode[char]) {
			currentNode = currentNode[char];
			isLastNode = Object.keys(currentNode).length === 0;
		} else {
			break;
		}
	}
	return isLastNode;
}

var radixTree = new RadixTree();

(function () {
	var startTime = new Date().getMilliseconds();
	debug(
		'PAC文件载入开始',
		'开始生成RadixTree',
		'直连域名:' + whiteList.length.toString()
		+ '|代理域名:' + blackList.length.toString()
		+ '|本地后缀:' + localSuffix.length.toString()
		+ '|本地前缀:' + localPrefix.length.toString(),
	);
	for (let i=0; i<geoipList.length; i++) {
		var cidr = geoipList[i];
		var [ip, prefixLen] = cidr.split('/');
		if (!cidr.includes(':')) {
			var ip = ip.match(/.{1,2}/g).map(function(byte) {
				return parseInt(byte, 16);
			}).join('.');
		}
		var bits = ipToBinary(ip).slice(0, prefixLen);
		radixTree.insert(bits);
	}
	radixTree = radixTree.to_list();
	var elapsed = new Date().getMilliseconds() - startTime;
	debug(
		'PAC文件载入完毕',
		'RadixTree已生成',
		'GEOIP地址:' + geoipList.length.toString()
		+ '|耗时:'+elapsed.toString() + '毫秒',
	);
})();

