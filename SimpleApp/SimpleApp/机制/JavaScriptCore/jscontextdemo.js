var add = function(a, b) {
    return a + b;
};

var selectSort = function(arr) {
    if (arr.length == 0) {
        return arr;
    }
    
    var min = 0;
    for (var i = 0; i < arr.length; i++) {
        min = i;
        for (var j = i + 1; j < arr.length; j++) {
            if (arr[i] < arr[j]) {
                min = j;
            }
        }
        
        arr[i] = arr[i] + arr[j];
        arr[j] = arr[i] - arr[j];
        arr[i] = arr[i] - arr[j];
    }
};

var insertSort = function(arr) {
    if (arr.length == 0) {
        return arr;
    }
    
    var temp = 0;
    for (var i = 1; i < arr.length; i++) {
        
        var j = 0;
        while (j++ < i) {
            if (arr[i] < arr[j]) {
                temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }
    
    return arr;
};

var login = function() {
    Native.login();
};

var cache = function(name, pwd) {
    if (arguments.length > 0) {
        Native.cacheNamePwd(name, pwd);
    } else {
        Native.cache();
    }
};
