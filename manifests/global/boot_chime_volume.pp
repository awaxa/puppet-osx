# Public: configure boot chime volume
class osx::global::boot_chime_volume (
  $ensure = '00',
) {
  validate_re($ensure, [ '^absent$', '^\d{2}$' ])
  case $ensure {
    'absent': {
      exec { 'Remove Boot Chime Volume NVRAM Variable':
        command => 'nvram -d SystemAudioVolume',
        onlyif  => 'nvram SystemAudioVolume',
        user    => 'root',
      }
    }
    default: {
      exec { 'Set Boot Chime Volume NVRAM Variable':
        command => "nvram SystemAudioVolume=%${ensure}",
        unless  => "nvram SystemAudioVolume | grep -q %${ensure}$",
        user    => 'root',
      }
    }
  }
}
