const update = obj => {
    const el = document.getElementById('result')
    el.innerText = JSON.stringify(obj, null, 4)
}

window.createKeyPair = async function createKeyPair() {
    var privateKey = await EVT.EvtKey.randomPrivateKey()
    var publicKey = EVT.EvtKey.privateToPublic(privateKey)

    update({ privateKey, publicKey })

    webkit.messageHandlers.ios.postMessage(JSON.stringify({ privateKey, publicKey }))
}
