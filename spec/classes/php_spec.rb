require 'spec_helper'

describe 'php', :type => :class do
  let(:facts) { { :osfamily        => 'Debian',
                  :lsbdistid       => 'Debian',
                  :operatingsystem => 'Debian',
                  :path            => '/usr/local/bin:/usr/bin:/bin' } }

  describe 'when called with no parameters on Debian' do
    it {
      should contain_package('php5-cli').with({
        'ensure' => 'latest',
      })
      should contain_class('php::fpm')
      should contain_package('php5-dev').with({
        'ensure' => 'latest',
      })
      should contain_package('php-pear').with({
        'ensure' => 'latest',
      })
      should contain_class('php::composer')
    }
  end

  describe 'when called with no parameters on Suse' do
    let(:facts) { { :osfamily => 'Suse',
                    :operatingsystem => 'SLES',
                    :path     => '/usr/local/bin:/usr/bin:/bin' } }
    it {
      should contain_package('php5').with({
        'ensure' => 'latest',
      })
      should contain_package('php5-devel').with({
        'ensure' => 'latest',
      })
      should contain_package('php5-pear').with({
        'ensure' => 'latest',
      })
      should_not contain_package('php5-cli')
      should_not contain_package('php5-dev')
      should_not contain_package('php-pear')
    }
  end

  describe 'when called with no parameters on RedHat' do
    let(:facts) { { :osfamily => 'RedHat',
                    :path     => '/usr/local/bin:/usr/bin:/bin' } }
    it {
      should contain_package('php').with({
        'ensure' => 'latest',
      })
      should contain_package('php-cli').with({
        'ensure' => 'latest',
      })
      should contain_package('php-devel').with({
        'ensure' => 'latest',
      })
      should contain_package('php-pear').with({
        'ensure' => 'latest',
      })
      should_not contain_package('php5-dev')
      should_not contain_package('php5-pear')
    }
  end

  describe 'when called with no parameters on Gentoo' do
    let(:facts) { { :osfamily => 'Gentoo',
                    :path     => '/usr/local/bin:/usr/bin:/bin' } }
    it {
      should contain_package_use('app-admin/eselect-php').with({
        'ensure' => 'present',
        'use'    => ['fpm']
      })
      should contain_package_use('dev-lang/php').with({
        'ensure' => 'present',
        'use'    => ['fpm']
      })
      should_not contain_package('php-cli')
      should_not contain_package('php-devel')
      should_not contain_package('php-pear')
      should_not contain_package('php5-dev')
      should_not contain_package('php5-pear')
    }
  end

  describe 'when fpm is disabled' do
    let(:params) { { :fpm => false, } }
    it {
      should_not contain_class('php::fpm')
    }
  end
  describe 'when composer is disabled' do
    let(:params) { { :composer => false, } }
    it {
      should_not contain_class('php::composer')
    }
  end
end
