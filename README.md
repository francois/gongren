# Gongren

A simple tool to manage a co-working space. This tool was developed for EspaceCO, a co-working space in Sherbrooke, QC, Canada.

# Features

* Invoicing and payment management are managed through Freshbooks: you will need an account at Freshbooks to use Gongren;
* Everything is represented as a "resource": a conference room, a projector, a desk, etc.;
* All resources know when they are busy of free;
* Fully l10ned and i18ned (French and English to start, others to come);
* more coming later!

# Installation

    # clone this repository
    vim config/database.yml
    bin/rake db:migrate
    FRESHBOOKS_CONSUMER_SECRET=... FRESHBOOKS_CONSUMER_KEY=sample bin/rails server

    # This would be the ideal
    gem install gongren
    gongren database init POSTGRES_DATABASE_URL
    FRESHBOOKS_CONSUMER_SECRET=... FRESHBOOKS_CONSUMER_KEY=sample gongren server start

Visit http://localhost:7654/ to continue with the setup.

# License

Copyright (c) 2014 François Beausoleil <francois@teksol.info>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
