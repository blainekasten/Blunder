// Generated by CoffeeScript 1.6.2
(function() {
  String.prototype.splice = function(index, rem, string) {
    return this.slice(0, index) + string + this.slice(index + Math.abs(rem));
  };

  String.prototype.indexByRegex = function(regex) {
    var indexOf;

    return indexOf = this.search(regex);
  };

  window.Blunder = (function() {
    function Blunder() {}

    Blunder.prototype.reverseParse = function(text) {
      text = this._replaceExpr(/(<b>|<\/b>)/, text, "^");
      text = this._replaceExpr(/(<i>|<\/i>)/, text, "~");
      text = this._replaceExpr(/(<u>|<\/u>)/, text, "_");
      text = this._replaceExpr(/<br\/>/, text, "\n");
      text = this._replaceExpr(/<li>/, text, "    ");
      return text = this._replaceLink(/'(.*?)'/, />(.*?)<\/a>/, text);
    };

    Blunder.prototype.parseText = function(text) {
      text = this._parseLink(/\[a\].*\n/, /\s(.+)/, text);
      text = this._parseExpr(/\^/, text, "<b>");
      text = this._parseExpr(/\~/, text, "<i>");
      text = this._parseExpr(/\_/, text, "<u>");
      text = this._parseExpr(/\n/, text, "<br/>", false);
      return text = this._parseExpr(/\s\s\s\s/, text, "<li>", false, true);
    };

    Blunder.prototype._parseExpr = function(expr, text, tag, closeTag, closeOnReturn) {
      var clTag;

      if (closeTag == null) {
        closeTag = true;
      }
      if (closeOnReturn == null) {
        closeOnReturn = false;
      }
      clTag = tag.splice(1, 0, "/");
      if (expr.test(text)) {
        text = text.replace(expr, tag);
        if (closeTag !== false) {
          text = text.replace(expr, clTag);
        }
        if (closeOnReturn === true) {
          text = text.replace(/\n/, clTag);
        }
        return this._parseExpr(expr, text, tag, closeTag, closeOnReturn);
      } else {
        return text;
      }
    };

    Blunder.prototype._parseLink = function(linkExpr, tagExpr, text) {
      var linkHref, linkSrc, linkTag, tag;

      if (/\[a\].*.\s\w.*/.test(text)) {
        if (text.match(linkExpr) === null) {
          return;
        } else {
          linkSrc = text.match(linkExpr)[0];
        }
        linkTag = linkSrc.match(tagExpr)[1];
        linkHref = linkSrc.match(/\[a\](.*)\s\b/)[1];
        tag = "<a href='" + linkHref + "'>" + linkTag + "</a><br/>";
        text = text.replace(/(\[a\].*.\s\w.*)\n/, tag);
        return this._parseLink(linkExpr, tagExpr, text);
      } else {
        return text;
      }
    };

    Blunder.prototype._replaceExpr = function(expr, text, mark) {
      if (expr.test(text)) {
        text = text.replace(expr, mark);
        return this._replaceExpr(expr, text, mark);
      } else {
        return text;
      }
    };

    Blunder.prototype._replaceLink = function(linkExpr, titleExpr, text) {
      var href, mark, title;

      if (titleExpr.test(text)) {
        href = text.match(linkExpr)[1];
        title = text.match(titleExpr)[1];
        mark = "[a]" + href + " " + title;
        text = text.replace(/(<a href=.*<\/a>)/, mark);
        return this._replaceLink(linkExpr, titleExpr, text);
      } else {
        return text;
      }
    };

    return Blunder;

  })();

}).call(this);
