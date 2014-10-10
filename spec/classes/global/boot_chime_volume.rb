require 'spec_helper'

describe 'osx::global::boot_chime_volume' do
  context 'when declared with default params' do
    it do
      should contain_exec('Set Boot Chime Volume NVRAM Variable').with({
        :command => 'nvram SystemAudioVolume=%00',
        :unless  => 'nvram SystemAudioVolume | grep -q %00$',
        :user    => 'root'
      })
    end
  end

  context 'when declared with ensure => absent' do
    let(:params) { {:ensure => 'absent'} }

    it do
      should contain_exec('Remove Boot Chime Volume NVRAM Variable').with({
        :command => 'nvram -d SystemAudioVolume',
        :onlyif  => 'nvram SystemAudioVolume',
        :user    => 'root'
      })
    end
  end

  context 'when declared with a single digit value for ensure' do
    let(:params) { {:ensure => '0'} }

    it do
      expect {
        should contain_exec('Set Boot Chime Volume NVRAM Variable')
      }.to raise_error(Puppet::Error, /validate_re.*/)
    end
  end
end
