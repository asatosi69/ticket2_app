!function(e){"function"==typeof define&&define.amd?define(["jquery"],e):e(jQuery)}(function(e){return e.ui=e.ui||{},e.ui.version="1.12.1"}),function(e){"function"==typeof define&&define.amd?define(["jquery","./version"],e):e(jQuery)}(function(e){return e.ui.escapeSelector=(n=/([!"#$%&'()*+,./:;<=>?@[\]^`{|}~])/g,function(e){return e.replace(n,"\\$1")});var n}),function(e){"function"==typeof define&&define.amd?define(["jquery","./version","./escape-selector"],e):e(jQuery)}(function(s){return s.fn.labels=function(){var e,n,i,t,r;return this[0].labels&&this[0].labels.length?this.pushStack(this[0].labels):(t=this.eq(0).parents("label"),(i=this.attr("id"))&&(r=(e=this.eq(0).parents().last()).add(e.length?e.siblings():this.siblings()),n="label[for='"+s.ui.escapeSelector(i)+"']",t=t.add(r.find(n).addBack(n))),this.pushStack(t))}});