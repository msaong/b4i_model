Type=StaticCode
Version=4.28
ModulesStructureVersion=1
B4i=true
@EndOfDesignText@
'Code module

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Dim Cipher As Cipher    'B4I
	Dim su As StringUtils
	Dim bc As ByteConverter
	Dim Password As String
End Sub

Sub encrypt(str As String) As String
	Return su.EncodeUrl(su.encodeBase64(Cipher.Encrypt(str.GetBytes("UTF8"), Password)), "UTF8")
End Sub


Sub decrypt (str As String) As String
	str=bc.StringFromBytes(Cipher.Decrypt(su.DecodeBase64(su.DecodeUrl(str, "UTF8")), Password),"UTF8")
	If str.Contains(Chr(0)) Then str=str.SubString2(0, str.IndexOf(Chr(0)))
	Return str
End Sub
Sub encryptFile(DirSource As String, fileSource As String, DirTarget As String, FileTarget As String)
	Dim time As Long  =DateTime.Now
 
	Dim in As InputStream
	in = File.OpenInput(DirSource, fileSource)
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	File.Copy2(in, out)

	Dim data() As Byte
	data = out.ToBytesArray
	data=Cipher.Encrypt(data, Password)
 
	Dim fname As RandomAccessFile
	fname.Initialize(DirTarget, FileTarget, False)
	fname.WriteB4XObject(data, 0)
	fname.Close
 
	time=DateTime.Now
End Sub

Sub decryptFile(DirSource As String, FileSource As String, DirTarget As String, FileTarget As String)
	Dim time As Long  =DateTime.Now

	Dim data() As Byte
	Dim fname As RandomAccessFile
	fname.Initialize(DirSource, FileSource, False)
	data=fname.ReadB4XObject(0)
	fname.Close
 
	data=Cipher.Decrypt(data, Password)

	Dim in As InputStream
	in.InitializeFromBytesArray(data, 0, data.Length)
	Dim out As OutputStream
	out=File.OpenOutput(DirTarget, FileTarget, False)
	File.Copy2(in, out)
	out.Close

	time=DateTime.Now
End Sub