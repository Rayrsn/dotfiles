# Defined in - @ line 1
function wc --wraps='windscribe connect' --description 'alias wc=windscribe connect'
  windscribe connect $argv;
end
