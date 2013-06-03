class window.Blunder

        #
        # reverseParse: (text) ->
        # @param text is the string which converts html elements into ~^_,etc
        #
        reverseParse: (text) ->
                text = @_replaceBolds(text)
                text = @_replaceItalics(text)
                text = @_replaceUnderlines(text)
                text = @_replaceReturns(text)
       
        #
        # parseText: (text) ->
        # @param text is the string to convert ~^_,etc into html elements
        #
        parseText: (text) ->
                text = @_findBolds(text)
                text = @_findItalics(text)
                text = @_findUnderlines(text)
                text = @_findReturns(text)

        #
        ## Private Methods used to do the actual replacements
        #
        
        _findBolds: (text) ->
                expr = /\^/
                if expr.test text 
                        text = text.replace(expr, "<b>")
                        text = text.replace(expr, "</b>")
                        @_findBolds(text) #Cycle back through until the test stops us
                else text

        _findItalics: (text) ->
                expr = /\~/
                if expr.test text 
                        text = text.replace(expr, "<i>")
                        text = text.replace(expr, "</i>")
                        @_findItalics(text) #Cycle back through until the test stops us
                else text
        
        _findUnderlines: (text) ->
                expr = /\_/
                if expr.test text 
                        text = text.replace(expr, "<u>")
                        text = text.replace(expr, "</u>")
                        @_findUnderlines(text) #Cycle back through until the test stops us
                else text
        
        _findReturns: (text) ->
                expr = /\n/
                if expr.test text 
                        text = text.replace(expr, "<br/>")
                        @_findReturns(text) #Cycle back through until the test stops us
                else text
        
        _replaceBolds: (text) ->
                expr = /(<b>|<\/b>)/
                if expr.test text
                        text = text.replace(expr, "^")
                        @_replaceBolds(text)
                else text
        
        _replaceItalics: (text) ->
                expr = /(<i>|<\/i>)/
                if expr.test text
                        text = text.replace(expr, "~")
                        @_replaceItalics(text)
                else text
        _replaceUnderlines: (text) ->
                expr = /(<u>|<\/u>)/
                if expr.test text
                        text = text.replace(expr, "_")
                        @_replaceUnderlines(text)
                else text
        _replaceReturns: (text) ->
                expr = /<br\/>/
                if expr.test text
                        text = text.replace(expr, "\n")
                        @_replaceReturns(text)
                else text

