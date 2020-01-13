name             'jenkins'
maintainer       'yury_muski'
maintainer_email 'some@ema.il'
license          'All rights reserved'
description      'Installs/Configures jenkins'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
issues_url 'https://github.com/chef-cookbooks/something/issues' if respond_to?(:issues_url)
source_url 'https://github.com/chef-cookbooks/something' if respond_to?(:source_url)

depends 'java'
depends 'tomcat'
depends 'nginx'

