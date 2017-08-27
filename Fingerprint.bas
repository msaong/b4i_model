Type=StaticCode
Version=4.28
ModulesStructureVersion=1
B4i=true
@EndOfDesignText@
'Code module

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.

End Sub
Sub ShowTouchID(SubHandler As Object, ApprovedSub As String, FailSub As String)
	Dim noMe As NativeObject=Me
	noMe.RunMethod("TouchID:::",Array(SubHandler,ApprovedSub,FailSub))
End Sub

Sub TouchOK
	Log("Touch Approved")
End Sub

Sub TouchFail(ErrorDescription As String)
	Log(ErrorDescription)
End Sub

#If OBJC

#import <LocalAuthentication/LocalAuthentication.h>

-(void)TouchID :(NSObject*)handler :(NSString*) subnameok :(NSString*) subnamefail
{
LAContext *myContext = [[LAContext alloc] init];
NSError *authError = nil;
NSString *myLocalizedReasonString = @"Used for quick and secure access to the test app";
if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
    [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
            if (success) {
                [self.__c CallSubDelayed:self.bi :handler :(subnameok)];
            } else {
                [self.__c CallSubDelayed2:self.bi :handler :(subnamefail) :(error.localizedDescription)];
            }
        }];
} else {
[self.__c CallSubDelayed2:self.bi :handler :(subnamefail) :(authError.localizedDescription)];

}
}


#End If