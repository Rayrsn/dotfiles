function wcpc --wraps='wc gb && protonvpn-cli c NL-Free#1 && wdc' --description 'alias wcpc=wc gb && protonvpn-cli c NL-Free#1 && wdc'
  warp-cli connect && protonvpn-cli c NL-Free#1 && warp-cli disconnect $argv;
end
