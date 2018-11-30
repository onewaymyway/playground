package filekit 
{
	import electrontools.MessageManager;
	import filetoolkit.FileKit;
	import laya.events.Event;
	import ui.deskplatform.LoginViewUI;
	/**
	 * ...
	 * @author ww
	 */
	public class LoginView extends LoginViewUI
	{
		private static var _instance:LoginView;
		public static function get instance():LoginView {
			return _instance ? _instance : _instance = new LoginView();
		}
		public function LoginView() 
		{
			loginBtn.on(Event.CLICK, this, onLoginBtn);
			FileKit.I.on(FileKit.Logined, this, onLoginSuccess);
			FileKit.I.on(FileKit.LoginFail, this, onLoginFail);
		}
		
		
		public function start():void {

			nameTxt.text = "";
			pwdTxt.text = "";
			nameTxt.focus = true;
			popup();

		}
		
		private function onLoginBtn():void
		{
			FileKit.I.username = nameTxt.text;
			FileKit.I.pwd = pwdTxt.text;
			FileKit.I.login();
		}
		
		private function onLoginFail():void
		{
			MessageManager.I.show("登录失败");
		}
		
		private function onLoginSuccess():void
		{
			MessageManager.I.show("登录成功");
			close();
		}
	}

}