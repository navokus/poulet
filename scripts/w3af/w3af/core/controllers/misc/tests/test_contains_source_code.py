# -*- encoding: utf-8 -*-
"""
test_contains_source_code.py

Copyright 2012 Andres Riancho

This file is part of w3af, http://w3af.org/ .

w3af is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation version 2 of the License.

w3af is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with w3af; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

"""
import unittest

from w3af.core.controllers.misc.contains_source_code import contains_source_code
from w3af.core.controllers.misc.contains_source_code import PHP, PYTHON, RUBY
from w3af.core.data.url.HTTPResponse import HTTPResponse
from w3af.core.data.parsers.doc.url import URL
from w3af.core.data.dc.headers import Headers


class TestContainsSourceCode(unittest.TestCase):

    def create_response(self, body, content_type=None):
        content_type = content_type if content_type is not None else 'text/html'
        headers = Headers([('Content-Type', content_type)])
        url = URL('http://www.w3af.org/')
        return HTTPResponse(200, body, headers, url, url)

    def test_php(self):
        source = self.create_response('foo <?php echo "a"; ?> bar')
        match, lang = contains_source_code(source)

        self.assertNotEqual(match, None)
        self.assertEqual(lang, {PHP})
    
    def test_no_code_case01(self):
        source = self.create_response('foo <?php echo "bar')
        match, lang = contains_source_code(source)
        
        self.assertEqual(match, None)
        self.assertEqual(lang, None)
    
    def test_no_code_case02(self):
        source = self.create_response('foo <?xml ?> "bar')
        match, lang = contains_source_code(source)
        
        self.assertEqual(match, None)
        self.assertEqual(lang, None)

    def test_no_code_case03(self):
        source = self.create_response('foo <?php xpacket ?> "bar')
        match, lang = contains_source_code(source)
        
        self.assertEqual(match, None)
        self.assertEqual(lang, None)

    def test_code_case04(self):
        source = self.create_response('foo <?php ypacket ?> "bar')
        match, lang = contains_source_code(source)
        
        self.assertNotEqual(match, None)
        self.assertEqual(lang, {PHP})

    def test_code_python(self):
        source = self.create_response('''
                 def foo(self):
                    pass
                 ''')
        match, lang = contains_source_code(source)

        self.assertNotEqual(match, None)
        self.assertEqual(lang, {PYTHON})

    def test_code_ruby(self):
        source = self.create_response('''class Person < ActiveRecord::Base
                        validates :name, presence: true
                    end''')
        match, lang = contains_source_code(source)

        self.assertNotEqual(match, None)
        self.assertEqual(lang, {RUBY})

    def test_code_false_positive_remove(self):
        source = self.create_response('var f=_.template("<div class="alert'
                                      ' alert-error <% if (title) { %>'
                                      ' alert-block <% } %>',
                                      content_type='application/javascript')
        match, lang = contains_source_code(source)
        self.assertEqual(match, None)
