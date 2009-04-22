" Vim filetype plugin file for adding getter/setter methods
" Language: PHP
" Maintainer: Sergio Carvalho <sergio.carvalho@portugalmail.com>
" Last Change: 2005 Jul 20
" Revision: 0.1
" Credit:
"    - Based on java_getset.vib by Pete Kazmier (pete-vim AT kazmier DOT com)
"
" -------------------------------------------------------------------------------
"   Copyright (c) 2005 Sergio Carvalho <sergio.carvalho@portugalmail.com>
" -------------------------------------------------------------------------------
"   php_getset.vim is free software; you can redistribute it and/or modify
"   it under the terms of the GNU Lesser General Public License as published by
"   the Free Software Foundation; either version 2.1 of the License, or
"   (at your option) any later version.
"
"   php_getset.vim is distributed in the hope that it will be useful,
"   but WITHOUT ANY WARRANTY; without even the implied warranty of
"   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"   GNU Lesser General Public License for more details.
"
"   You should have received a copy of the GNU Lesser General Public License
"   along with php_getset.vim; if not, write to the Free Software
"   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
"   02111-1307 USA
" -------------------------------------------------------------------------------
"   Author: Sergio Carvalho <sergio.carvalho@portugalmail.com>
" -------------------------------------------------------------------------------
"
" This filetype plugin provides a couple of code templates for PHP5
" development. The code is formatted according to PEAR Coding Standards.
"
" The three provided templates are:
"  - Class file template
"  - Method docblock template
"  - Field getter and setter template
"
" Install by placing the file in ~/.vim/ftplugin. To use:
" For the method docblock and getter/setter templates, just write the code as 
" usual. A mapping is triggered when you type ( after the method name, and
" when you type the ; after the field definition.
" For the class file template, type 'class' in normal mode. You'll be prompted
" for relevant information, and the class skeleton will be generated.
if exists("b:did_phpclass_plugin")
  finish
endif
let b:did_phpclass_plugin = 1

" Make sure we are in vim mode
let s:save_cpo = &cpo
set cpo&vim

let s:indent = ''
let s:function_regexp = '\(public\|private\|protected\)\( static\)\? function \([^(]*\)('
"let s:field_regexp = '\(public\|private\|protected\)\( static\)\? \$\([a-zA-Z_][a-zA-Z0-9_]*\)\(.*=.*\);'

" Insert a method docblock template, iff no docblock exists for the method
" (and we are actually in a method line)
"
" This function inserts a docblock template above the current line. It will
" abort and do nothing if one of these is true:
"  - The current line is not a method declaration
"  - The line above the current one looks like the end of a docblock
if !exists("TryMethodDocblock")
    function! TryMethodDocblock()
        if (match(getline(line('.')), s:function_regexp) == -1 || 
          \ (line('.') != 1 &&
          \  match(getline(line('.') - 1), '/\* }}} \*/') == -1 &&
          \  match(getline(line('.') - 1), '*/') != -1
          \ )
          \)
            return
        endif
        
        let function = substitute(getline(line('.')), s:function_regexp, '\3', 'g')

        let text = s:phptemplate_functiondocblock
        let text = substitute(text, '%function%', function, 'g')

        call s:append_text(line('.') - 1, text)
"        call append(line('.'), '    /* }}} */')

    endfunction
endif

"let s:field_regexp = '\( *\(public\|private\|protected\)\( static\)\? \$\([a-zA-Z_][a-zA-Z0-9_]*\)\(\( = \| =\|=\|= \)\(array\)\?.*\)\?;\)'
if !exists("TryGetterSetter")
    function! TryGetterSetter()
"        if (match(getline(line('.')), s:field_regexp) == -1 
"          \)
"            return
"        endif
"
"        let visibility = substitute(getline(line('.')), s:field_regexp, '\2', 'g')
"        let static = substitute(getline(line('.')), s:field_regexp, '\3', 'g')
"        let name = substitute(getline(line('.')), s:field_regexp, '\4', 'g')
"        call append(line('.'), name)
"        normal j^gUl
"        let Name = getline(line('.'))
"        normal ddk
"        let defaultValue = substitute(getline(line('.')), s:field_regexp, '\5', 'g')
"        let isArray = substitute(getline(line('.')), s:field_regexp, '\7', 'g') == 'array'
"
"        if (isArray)
"            let text = s:phptemplate_arraygettersetter
"        else
"            let text = s:phptemplate_gettersetter
"        endif
"
"        let text = substitute(text, '%visibility%', visibility, 'g')
"        let text = substitute(text, '%static%', static, 'g')
"        let text = substitute(text, '%name%', name, 'g')
"        let text = substitute(text, '%Name%', Name, 'g')
"        let text = substitute(text, '%defaultValue%', defaultValue, 'g')
"        if (static == '')
"            let text = substitute(text, '%thisOrSelf%', '$this->', 'g')
"        else
"            let text = substitute(text, '%thisOrSelf%', 'self::$', 'g')
"        endif
"
"        call s:append_text(line('.') - 1, text)
"        call append(line('.'), '    ')
"        normal ddkzcj
    endfunction
endif

if !exists("InsertClass")
    function! InsertClass() range
        let text = s:phptemplate_class

        let text = s:parameterize_template(text, "Class name? ", '%classname%')
        let text = s:parameterize_template(text, "Package name? ", '%package%')
        let text = s:parameterize_template(text, "Subpackage name? ", '%sub_package%')
        let text = substitute(text, '%author%', 'Christian Senkowski <c.senkowski@kon.de>', 'g')
        let text = substitute(text, '%since%', strftime("%Y%m%d %H:%M"), 'g')

        call s:append_text(line('.'), text)
        normal dd
        set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
    endfunction
endif

if !exists("InsertContainer")
    function! InsertContainer() range
        let text = s:phptemplate_container

        let text = s:parameterize_template(text, "Class name? ", '%classname%')
        let text = s:parameterize_template(text, "Package name? ", '%package%')
        let text = s:parameterize_template(text, "Subpackage name? ", '%sub_package%')
        let text = s:parameterize_template(text, "default instance name? ", '%default_name%')
        let text = substitute(text, '%author%', 'Christian Senkowski <c.senkowski@kon.de>', 'g')
        let text = substitute(text, '%since%', strftime("%Y%m%d %H:%M"), 'g')

        call s:append_text(line('.'), text)
        normal dd
        set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
    endfunction
endif

if !exists("InsertFactory")
    function! InsertFactory() range
        let text = s:phptemplate_factory
        
        let text = s:parameterize_template(text, "Class name? ", '%classname%')
        let text = s:parameterize_template(text, "Package name? ", '%package%')
        let text = s:parameterize_template(text, "Subpackage name? ", '%sub_package%')
        let text = substitute(text, '%author%', 'Christian Senkowski <c.senkowski@kon.de>', 'g')
        let text = substitute(text, '%since%', strftime("%Y%m%d %H:%M"), 'g')

        call s:append_text(line('.'), text)
        normal dd
        set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
    endfunction
endif

if !exists("InsertInterface")
    function! InsertInterface() range
        let text = s:phptemplate_interface
        
        let text = s:parameterize_template(text, "Interface name? ", '%classname%')
        let text = s:parameterize_template(text, "Package name? ", '%package%')
        let text = s:parameterize_template(text, "Subpackage name? ", '%sub_package%')
        let text = substitute(text, '%author%', 'Christian Senkowski <c.senkowski@kon.de>', 'g')
        let text = substitute(text, '%since%', strftime("%Y%m%d %H:%M"), 'g')

        call s:append_text(line('.'), text)
        normal dd
        set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker foldlevel=0
    endfunction
endif


if !exists("*s:parameterize_template")
    function s:parameterize_template(template, prompt, marker)
        return substitute(a:template, a:marker, input(a:prompt), 'g')
    endfunction
endif

if !exists("*s:append_text")
  function s:append_text(pos, text)
    let pos = a:pos
    let string = a:text

    while 1
      let len = stridx(string, "\n")

      if len == -1
        call append(pos, s:indent . string)
        break
      endif

      call append(pos, s:indent . strpart(string, 0, len))

      let pos = pos + 1
      let string = strpart(string, len + 1)

    endwhile
  endfunction
endif

if exists("b:phptemplate_class")
  let s:phptemplate_class = b:phpclass_template
else
  let s:phptemplate_class =
    \ "<?php\n" .
    \ "\/**\n" .
    \ " * class.%classname%.php\n" . 
    \ " *\n" . 
    \ " * @package %package%\n" .
    \ " * @subpackage %sub_package%\n" .
    \ " * @author %author%\n" .
    \ " * @since %since%\n" .
    \ " *\n" .
    \ " * @version $Id: php_template.vim 126 2007-10-01 04:53:21Z adar $\n" .
    \ " */\n" .
    \ "\n" .
    \ "\/**\n" .
    \ " * class %classname%\n" .
    \ " *\n" .
    \ " * @package %package%\n" .
    \ " * @subpackage %sub_package%\n" .
    \ " * @author %author%\n" .
    \ " * @since %since%\n" .
    \ " */\n" .
    \ "class %classname% {\n\n" .
    \ "    /**\n" .
    \ "     * Create new %classname%\n" .
    \ "     *\n" .
    \ "     * @return %classname%\n" .
    \ "     * @author %author%\n" .
    \ "     * @since %since%\n" .
    \ "     */\n" .
    \ "    public function __construct() {\n" .
    \ "    }\n\n" .
    \ "    /**\n" . 
    \ "     * What to do if undefined method was called\n" .
    \ "     *\n" . 
    \ "     * @param string function name\n" . 
    \ "     * @param string[] vars this function was called with\n" . 
    \ "     * @return void\n" . 
    \ "     * @throws Exception\n" . 
    \ "     * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "     * @since %since%\n" . 
    \ "     */\n" . 
    \ "    public function __call($func, $var) {\n" . 
    \ "        throw new Exception(__CLASS__.': Could not find method \"'.$func.'\" called with \"'.var_export($var, true).'\"');\n" . 
    \ "    }\n\n" . 
    \ "    /**\n" . 
    \ "     * Get classname\n" .
    \ "     *\n" . 
    \ "     * @return string\n" . 
    \ "     * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "     * @since %since%\n" . 
    \ "     */\n" . 
    \ "    public function getClassName() {\n" . 
    \ "        return __CLASS__;\n" . 
    \ "    }\n\n" . 
    \ "    /**\n" .
    \ "     * Free resources held by %classname%\n" .
    \ "     *\n" .
    \ "     * @return void\n" .
    \ "     * @author %author%\n" .
    \ "     * @since %since%\n" .
    \ "     */\n" .
    \ "    public function __destruct() {\n" .
    \ "    }\n" .
    \ "}\n\n" .
    \ "\/**\n" .
    \ " *  vim: set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker:\n" .
    \ " */\n" .
    \ "?>"
endif

if exists("b:phptemplate_container")
    let s:phptemplate_container = b:phptemplate_class
else
    let s:phptemplate_container =
    \ "<?php\n" . 
    \ "\/**\n" .
    \ " * class.%classname%.php\n" . 
    \ " *\n" . 
    \ " * @package %package%\n" .
    \ " * @subpackage %sub_package%\n" .
    \ " * @author %author%\n" .
    \ " * @since %since%\n" .
    \ " *\n" .
    \ " * @version $Id: php_template.vim 126 2007-10-01 04:53:21Z adar $\n" .
    \ " */\n" .
    \ "\n" .
    \ "\/**\n" .
    \ " * class %classname%\n" .
    \ " *\n" .
    \ " * @package %package%\n" .
    \ " * @subpackage %sub_package%\n" .
    \ " * @author %author%\n" .
    \ " * @since %since%\n" .
    \ " */\n" .
    \ "class %classname% {\n\n" .
    \ "    private static $instances = NULL;\n\n" . 
    \ "    /**\n" .
    \ "     * Create new %classname%\n" .
    \ "     *\n" .
    \ "     * @return %classname%\n" .
    \ "     * @author %author%\n" .
    \ "     * @since %since%\n" .
    \ "     */\n" .
    \ "    private function __construct($name='%default_name%') {\n" .
    \ "        self::$instances[ $name ] = $this;\n" . 
    \ "    }\n\n" .
    \ "    /**\n" . 
    \ "     * What to do if undefined method was called\n" .
    \ "     *\n" . 
    \ "     * @param string function name\n" . 
    \ "     * @param string[] vars this function was called with\n" . 
    \ "     * @return void\n" . 
    \ "     * @throws Exception\n" . 
    \ "     * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "     * @since %since%\n" . 
    \ "     */\n" . 
    \ "    public function __call($func, $var) {\n" . 
    \ "        throw new Exception(__CLASS__.': Could not find method \"'.$func.'\" called with \"'.var_export($var, true).'\"');\n" . 
    \ "    }\n\n" . 
    \ "    /**\n" . 
    \ "     * Get classname\n" .
    \ "     *\n" . 
    \ "     * @return string\n" . 
    \ "     * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "     * @since %since%\n" . 
    \ "     */\n" . 
    \ "    public function getClassName() {\n" . 
    \ "        return __CLASS__;\n" . 
    \ "    }\n\n" . 
    \ "    /**\n" .
    \ "     * Get an instance\n" .
    \ "     *\n" .
    \ "     * @return %classname%\n" .
    \ "     * @author %author%\n" .
    \ "     * @since %since%\n" .
    \ "     */\n" .
    \ "    public static function getInstance($name='%default_name%') {\n" .
    \ "        if ( self::$instances === NULL )\n" . 
    \ "            self::$instances = array();\n\n" . 
    \ "        if ( isset(self::$instances[ $name ]) ) {\n" .
    \ "            return self::$instances[ $name ];\n" .
    \ "        }\n" .
    \ "        return new %classname%($name);\n" .
    \ "    }\n\n" . 
    \ "    /**\n" .
    \ "     * Free resources held by %classname%\n" .
    \ "     *\n" .
    \ "     * @return void\n" .
    \ "     * @author %author%\n" .
    \ "     * @since %since%\n" .
    \ "     */\n" .
    \ "    public function __destruct() {\n" .
    \ "    }\n" .
    \ "}\n\n" .
    \ "\/**\n" .
    \ " *  vim: set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker:\n" .
    \ " */\n" .
    \ "?>"
endif

if exists("b:phptemplate_factory")
  let s:phptemplate_factory = b:phpfactory_template
else
  let s:phptemplate_factory =
    \ "<?php\n" .
    \ "\/**\n" .
    \ " * class.%classname%.php\n" . 
    \ " *\n" . 
    \ " * @package %package%\n" .
    \ " * @subpackage %sub_package%\n" .
    \ " * @author %author%\n" .
    \ " * @since %since%\n" .
    \ " *\n" .
    \ " * @version $Id: php_template.vim 126 2007-10-01 04:53:21Z adar $\n" .
    \ " */\n" .
    \ "\n" .
    \ "\/**\n" .
    \ " * class %classname%\n" .
    \ " *\n" .
    \ " * @package %package%\n" .
    \ " * @subpackage %sub_package%\n" .
    \ " * @author %author%\n" .
    \ " * @since %since%\n" .
    \ " */\n" .
    \ "class %classname% {\n\n" .
    \ "    /**\n" .
    \ "     * Create new %classname%\n" .
    \ "     *\n" .
    \ "     * @return %classname%\n" .
    \ "     * @author %author%\n" .
    \ "     * @since %since%\n" .
    \ "     */\n" .
    \ "    public function __construct() {\n" .
    \ "    }\n\n" .
    \ "    /**\n" . 
    \ "     * What to do if undefined method was called\n" .
    \ "     *\n" . 
    \ "     * @param string function name\n" . 
    \ "     * @param string[] vars this function was called with\n" . 
    \ "     * @return void\n" . 
    \ "     * @throws Exception\n" . 
    \ "     * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "     * @since %since%\n" . 
    \ "     */\n" . 
    \ "    public function __call($func, $var) {\n" . 
    \ "        throw new Exception(__CLASS__.': Could not find method \"'.$func.'\" called with \"'.var_export($var, true).'\"');\n" . 
    \ "    }\n\n" . 
    \ "    /**\n" . 
    \ "     * Get classname\n" .
    \ "     *\n" . 
    \ "     * @return string\n" . 
    \ "     * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "     * @since %since%\n" . 
    \ "     */\n" . 
    \ "    public function getClassName() {\n" . 
    \ "        return __CLASS__;\n" . 
    \ "    }\n\n" . 
    \ "    /**\n" . 
    \ "     * Factory\n" . 
    \ "     *\n" . 
    \ "     * @param array $row\n" . 
    \ "     * @return %classname%\n" . 
    \ "     * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "     * @since 20070705 15:47\n" . 
    \ "     */\n" . 
    \ "    public static function factory(array $row) {\n" . 
    \ "        if ( empty($row) )\n" . 
    \ "            return NULL;\n" . 
    \ "        $obj = new self();\n\n" . 
    \ "        return $obj;\n" . 
    \"     }\n\n" . 
    \ "    /**\n" .
    \ "     * Free resources held by %classname%\n" .
    \ "     *\n" .
    \ "     * @return void\n" .
    \ "     * @author %author%\n" .
    \ "     * @since %since%\n" .
    \ "     */\n" .
    \ "    public function __destruct() {\n" .
    \ "    }\n" .
    \ "}\n\n" .
    \ "\/**\n" .
    \ " *  vim: set expandtab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker:\n" .
    \ " */\n" .
    \ "?>"
endif

if exists("b:phptemplate_interface")
  let s:phptemplate_interface = b:phpinterface_template
else
  let s:phptemplate_interface =
    \"<?php\n" . 
    \"\/**\n" . 
    \" * interface.%classname%.php\n" . 
    \" *\n" . 
    \" * @package %package%\n" . 
    \" * @subpackage %sub_package%\n" . 
    \" * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \" * @since %since%\n" . 
    \" *\n" . 
    \" * @version $Id: php_template.vim 126 2007-10-01 04:53:21Z adar $\n" . 
    \" */\n\n" . 
    \"\/**\n" . 
    \" * Interface %classname%\n" . 
    \" *\n" . 
    \" * @package %package%\n" . 
    \" * @subpackage %sub_package%\n" . 
    \" * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \" * @since %since%\n" . 
    \" */\n" . 
    \"interface %classname% {\n" . 
    \"    public function __construct();\n" . 
    \"    public function __call($func, $var);\n" . 
    \"    public function getClassName();\n" . 
    \"    public function __destruct();\n" . 
    \"}\n\n" . 
    \"?>\n"
endif

if exists("b:phptemplate_functiondocblock")
  let s:phptemplate_functiondocblock = b:phptemplate_functiondocblock
else
  let s:phptemplate_functiondocblock =
    \ "\t/**\n" .
    \ "\t * Klassendefinition\n" .
    \ "\t *\n" .
    \ "\t * @param \n" .
    \ "\t * @return void\n" .
    \ "\t * @author Christian Senkowski <c.senkowski@kon.de>\n" . 
    \ "\t * @since ".strftime("%Y%m%d %H:%M")."\n" . 
    \ "\t */"
endif

if exists("b:phptemplate_gettersetter")
  let s:phptemplate_gettersetter = b:phptemplate_gettersetter
else
  let s:phptemplate_gettersetter =
    \ "\n" .
    \ "\t/**\n".
    \ "\t * TODO: Field short description \n" .
    \ "\t */\n" .
    \ "\t%visibility%%static% $%name%%defaultValue%;\n\n" .
    \ "\t/**\n" .
    \ "\t* %name% Getter\n" .
    \ "\t*\n" .
    \ "\t* @TODO Change return type\n" .
    \ "\t* @return mixed\n" .
    \ "\t*/\n" .
    \ "\tpublic%static% function get%Name%() {\n" .
    \ "\t\treturn %thisOrSelf%%name%;\n" .
    \ "\t}\n\n" .
    \ "\t/**\n" .
    \ "\t * %name% Setter\n" .
    \ "\t *\n" .
    \ "\t * @TODO Change param type\n" .
    \ "\t * @param mixed\n" .
    \ "\t */\n" .
    \ "\tpublic%static% function set%Name%($value) {\n" .
    \ "\t\t%thisOrSelf%%name% = $value;\n" .
    \ "\t}"
endif

if exists("b:phptemplate_arraygettersetter")
  let s:phptemplate_arraygettersetter = b:phptemplate_arraygettersetter
else
  let s:phptemplate_arraygettersetter = 
    \ "\n" .
    \ "\t/**\n" . 
    \ "\t * TODO: Field short description \n" .
    \ "\t */\n" .
    \ "\t%visibility%%static% $%name%%defaultValue%;\n\n" .
    \ "\t/**\n" .
    \ "\t * %name% Getter\n" .
    \ "\t *\n" .
    \ "\t * @TODO Change return type\n" .
    \ "\t * @return mixed\n" .
    \ "\t */\n" .
    \ "\tpublic%static% function get%Name%() { \n" .
    \ "\t\treturn %thisOrSelf%%name%;\n" .
    \ "\t}\n" .
    \ "\n" .
    \ "\t/**\n" .
    \ "\t * %name% Setter\n" .
    \ "\t *\n" .
    \ "\t * @TODO Change param type\n" .
    \ "\t * @param mixed %name% new value\n" .
    \ "\t */\n" .
    \ "\t%visibility%%static% function set%Name%($value) {\n" .
    \ "\t\t%thisOrSelf%%name% = $value;\n" .
    \ "\t}\n\n" .
    \ "\t/**\n" .
    \ "\t * Add a new element to the %Name% array.\n" .
    \ "\t *\n" .
    \ "\t * @TODO Pick one of the two signatures below\n" .
    \ "\t *\n" .
    \ "\t * @param mixed Key for new value insertion\n" .
    \ "\t * @param mixed New value\n" .
    \ "\t * or\n" .
    \ "\t * @param mixed New value\n" .
    \ "\t */\n" .
    \ "\tpublic%static% function add%Name%($valueOrKey, $value = null) {\n" .
    \ "\t\tif (is_null($value)) {\n" .
    \ "\t\t\t%thisOrSelf%%name%[] = $valueOrKey;\n" .
    \ "\t\t} else {\n" .
    \ "\t\t\t%thisOrSelf%%name%[$valueOrKey] = $value;\n" .
    \ "\t\t}\n" .
    \ "\t}"
endif
