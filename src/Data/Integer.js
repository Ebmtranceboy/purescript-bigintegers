
export const fromInt = function (n) {
  return BigInt(n);
} 

export const inferior = function (n) {
  return function (m) {
      return n<m;
  };
}

export const superior = function (n) {
    return function(m) {
        return n>m;
    };
} 

export const eqImpl = function (n) {
    return function(m) {
        return n==m;
    };
} 

export const addImpl = function (n) {
    return function (m)  {
        return n+m;
    };
}

export const mulImpl = function (n) {
    return function (m) {
        return n*m;
    };
}

export const subImpl = function (n) {
    return function (m) {
        return n-m;
    };
}

export const divImpl = function (n) {
    return function (m) {
        return n/m;
    };
}

export const modImpl = function (n) {
    return function (m) {
        return n%m;
    };
}

export const degreeImpl = function (n) {
  return 0;
} 

export const showImpl = function (n) {
  return n;
} 

export const fromStringAsImpl = function (just) {
  return function (nothing) {
    return function (radix) {
      var digits;
      if (radix < 11) {
        digits = "[0-" + (radix - 1).toString() + "]";
      } else if (radix === 11) {
        digits = "[0-9a]";
      } else {
        digits = "[0-9a-" + String.fromCharCode(86 + radix) + "]";
      }
      var pattern = new RegExp("^[\\+\\-]?" + digits + "+$", "i");

      return function (s) {
        /* jshint bitwise: false */
        if (pattern.test(s)) {
          var i;
          switch(radix) {
            case 2:
                i = BigInt("0b" + s);
                break;
            case 8:
                i = BigInt("0o" + s);
                break;
            case 10:
                i = BigInt(s);
                break;
            case 16:
                i = BigInt("0x" + s);
                break;
            default:
                i = null;
            };
          return (i | 0n) === i ? just(i) : nothing;
        } else {
          return nothing;
        }
      };
    };
  };
};


export const toStringAs = function (radix) {
  return function (i) {
    return i.toString(radix);
  };
};
