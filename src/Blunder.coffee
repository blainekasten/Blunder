String.prototype.splice = (index, rem, string) ->
        @.slice(0, index) + string + @.slice(index + Math.abs(rem))

class window.Blunder

        #
        # reverseParse: (text) ->
        # @param text is the string which converts html elements into ~^_,etc
        #
        reverseParse: (text) ->
                text = @_replaceExpr(/(<b>|<\/b>)/, text, "^")          #Bold
                text = @_replaceExpr(/(<i>|<\/i>)/, text, "~")          #Italic
                text = @_replaceExpr(/(<u>|<\/u>)/, text, "_")          #Underline
                text = @_replaceExpr(/<br\/>/, text, "\n")              #Line breaks
                text = @_replaceExpr(/<li>/, text, "    ")              #list
       
        #
        # parseText: (text) ->
        # @param text is the string to convert ~^_,etc into html elements
        #
        parseText: (text) ->
                text = @_parseExpr(/\^/, text, "<b>")                #Bold
                text = @_parseExpr(/\~/, text, "<i>")                #Italics
                text = @_parseExpr(/\_/, text, "<u>")                #Underlines
                text = @_parseExpr(/\n/, text, "<br/>", false)       #line breaks
                text = @_parseExpr(/\s\s\s\s/, text, "<li>", false, true)       #list

        #
        ## Private Methods used to do the actual replacements
        #
        
        _parseExpr: (expr, text, tag, closeTag = true, closeOnReturn = false) ->
                clTag = tag.splice(1,0,"/")
                if expr.test text 
                        console.log( "#{expr} passed the test" )
                        text = text.replace(expr, tag)
                        text = text.replace(expr, clTag) unless closeTag is false
                        text = text.replace(/\n/, clTag) unless closeOnReturn is false
                        @_parseExpr(expr, text, tag, closeTag, closeOnReturn) #Cycle back through until the test stops us
                else text
        
        _replaceExpr: (expr, text, mark) ->
                if expr.test text
                        text = text.replace(expr, mark)
                        @_replaceExpr(expr, text, mark)
                else text
