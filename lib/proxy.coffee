http = require 'http'

exports.startProxy = (srvUrl, options) ->
  if not srvUrl
    throw new Error 'srvUrl not given'

  proxySrv = http.createServer()
  proxySrvPort = options?.port || 8080
  clients = []

  srvReq = http.request srvUrl

  srvReq.on 'response', (srvResp) ->
    proxySrv.on 'request', (clientReq, proxyResp) ->
      proxyResp.writeHead 200, srvResp.headers
      clients.push proxyResp
      proxyResp.socket.on 'close', ->
        clients.splice clients.indexOf(proxyResp), 1
    proxySrv.listen proxySrvPort
    srvResp.on 'data', (chunk) ->
      for client in clients
        client.write chunk, 'binary'

  srvReq.on 'close', ->
    try
      proxySrv.close options?.onCloseCallback
    catch err
      if err.message != 'Not running'
        throw err
    for client in clients
      client.end()

  srvReq.on 'error', options?.onErrorCallback

  srvReq.end()

