function wrpsrv --wraps='sudo systemctl start warp-svc.service' --description 'alias wrpsrv sudo systemctl start warp-svc.service'
  sudo systemctl start warp-svc.service $argv; 
end
