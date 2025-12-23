unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ShellApi, pngimage, RXCtrls, ComCtrls,
  Menus, abfComponents, DateUtils;

type
//------------------------------------
Campos = Array[1..2] of String;
//------------------------------------

type
  TForm1 = class(TForm)
    btn_jogar: TRxSpeedButton;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Sobre1: TMenuItem;
    abfWav1: TabfWav;
    Image1: TImage;
    Panel1: TPanel;
    Registro1: TMenuItem;
    thedig: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_jogarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure abfWav1PlayAfter(Sender: TObject);
    procedure abfWav1PlayBefore(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Registro1Click(Sender: TObject);
  private
    { Private declarations }
  public
  DIR_App:String;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
AbfWav1.FileName:=DIR_App+'BIN\lucas_voice.wav';
StatusBar1.Panels[1].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
end;

procedure TForm1.btn_jogarClick(Sender: TObject);
begin
AbfWav1.Play;
end;

procedure TForm1.abfWav1PlayAfter(Sender: TObject);
begin
//-------------------------------------
Sleep(1000);
//-------------------------------------

ShellExecute(Handle,'open',pchar('"'+DIR_App+'BIN\scummvm.exe'+'"')
                          ,pchar('-f -n -c"'+DIR_App+'\LUCAS\DIG'+'\scumm.ini"'+' -p"'+DIR_App+'\LUCAS\DIG'+'" '+'dig')
                          ,pchar(DIR_App)
                          ,SW_HIDE);

//-------------------------------------
Sleep(4000);
//-------------------------------------
btn_jogar.Caption:='INICIAR';
btn_jogar.Enabled:=True;
Form1.Cursor:=crDefault;
end;

procedure TForm1.abfWav1PlayBefore(Sender: TObject);
begin
//-------------------------------------
btn_jogar.Caption:='Iniciando...';
btn_jogar.Enabled:=False;
Form1.Cursor:=crHourGlass;
//-------------------------------------
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Sobre1Click(Sender: TObject);
begin
ShellExecute(Handle,'open','http://phobosfreeware.blogspot.com','','',1);
end;

procedure TForm1.Registro1Click(Sender: TObject);
begin
AboutBox.Visible:=True;
Form1.Enabled:=False;
end;

end.
