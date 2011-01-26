Installation
------------

Install Option 1: Have ORM settings auto Installed for you.

1. Create a Zip file of the source code with this directory as your top level directory.
2. Install Zip files as a plugin to Mura CMS and Deploy.
3. In configuring the Plug-In settings choose to 'Automatically Install ORM Settings'
4. Click update.

Install Option 2: ORM Manual setup.

1. Create a Zip file of the source code with this directory as your top level directory.
2. Install Zip files as a plugin to Mura CMS and Deploy.
3. In configuring the Plug-In settings choose NOT to 'Automatically Install ORM Settings'
4. Click Update.
5. Open your the cfapplication.cfm file located here: muraroot/plugins/Slatwall_[ID]/cfapplication.cfm, and remove the two comment lines that say "remove this line" both at the top and the bottom of the slatwall code block.


Documentation
-------------

Please view the project documentation here: https://github.com/gregmoser/Slatwall/wiki


Contribution
------------

Slatwall is an Open Source project that is made possible by the support of fellow developers.  For more information on how to get involved please reference the "Contribution" section of our development guide that is located here: https://github.com/gregmoser/Slatwall/wiki/Developer-Guide


License
-------

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.