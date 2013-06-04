// Generated by CoffeeScript 1.6.2
(function() {
  String.prototype.splice = function(index, rem, string) {
    return this.slice(0, index) + string + this.slice(index + Math.abs(rem));
  };

  window.Blunder = (function() {
    function Blunder() {}

    Blunder.prototype.reverseParse = function(text) {
      text = this._replaceExpr(/(<b>|<\/b>)/, text, "^");
      text = this._replaceExpr(/(<i>|<\/i>)/, text, "~");
      text = this._replaceExpr(/(<u>|<\/u>)/, text, "_");
      text = this._replaceExpr(/<br\/>/, text, "\n");
      return text = this._replaceExpr(/<li>/, text, "    ");
    };

    Blunder.prototype.parseText = function(text) {
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

    Blunder.prototype._replaceExpr = function(expr, text, mark) {
      if (expr.test(text)) {
        text = text.replace(expr, mark);
        return this._replaceExpr(expr, text, mark);
      } else {
        return text;
      }
    };

    return Blunder;

  })();

}).call(this);
