
let okInt32 = PDRPluginResult(status: PDRCommandStatusOK, messageAs: 123 as Int32)
let okString = PDRPluginResult(status: PDRCommandStatusOK, messageAs: "123 as Int32")
let okDouble = PDRPluginResult(status: PDRCommandStatusOK, messageAs: 123 as Double)
let okDic = PDRPluginResult(status: PDRCommandStatusOK, messageAs: ["A": 1])
let okStringArray = PDRPluginResult(status: PDRCommandStatusOK, messageAs: ["A", "B"])
let okIntArray = PDRPluginResult(status: PDRCommandStatusOK, messageAs: [1, 2])

let errorInt32 = PDRPluginResult(status: PDRCommandStatusError, messageAs: 123 as Int32)
let errorString = PDRPluginResult(status: PDRCommandStatusError, messageAs: "123 as Int32")
let errorDouble = PDRPluginResult(status: PDRCommandStatusError, messageAs: 123 as Double)
let errorDic = PDRPluginResult(status: PDRCommandStatusError, messageAs: ["A": 1])
let errorStringArray = PDRPluginResult(status: PDRCommandStatusError, messageAs: ["A", "B"])
let errorIntArray = PDRPluginResult(status: PDRCommandStatusError, messageAs: [1, 2])


errorDouble?.toJSONString()	String?	"{\"status\":2,\"message\":123,\"keepCallback\":false}"	some
errorInt32?.toJSONString()	String?	"{\"status\":2,\"message\":123,\"keepCallback\":false}"	some
errorIntArray?.toJSONString()	<Exception>
errorString?.toJSONString()	<Exception>
errorStringArray?.toJSONString()	<Exception>
okDic?.toJSONString()	<Exception>
okDouble?.toJSONString()	String?	"{\"status\":1,\"message\":123,\"keepCallback\":false}"	some
okInt32?.toJSONString()	String?	"{\"status\":1,\"message\":123,\"keepCallback\":false}"	some
okIntArray?.toJSONString()	String?	nil	none
okString?.toJSONString()	<Exception>
okStringArray?.toJSONString()	String?	nil	none

// 只有使用数字是安全的