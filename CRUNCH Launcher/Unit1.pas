unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ShellApi, pngimage, RXCtrls, ComCtrls,
  Menus, abfComponents, DateUtils, ToolWin, Buttons;

type
  TForm1 = class(TForm)
    crunch: TImage;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Sobre1: TMenuItem;
    abfWav1: TabfWav;
    Timer1: TTimer;
    Registro1: TMenuItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ComboBox1: TComboBox;
    btn_jogar: TSpeedButton;
    ToolButton1: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure abfWav1PlayAfter(Sender: TObject);
    procedure abfWav1PlayBefore(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Registro1Click(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure btn_jogarClick(Sender: TObject);
  private
    { Private declarations }
  public
  DIR_App:String;
    { Public declarations }

  end;

var
  Form1:TForm1;
  drive:String;

implementation

uses Unit3;

{$R *.dfm}

function ExtractName(const Filename: String): String;
var
aExt : String;
aPos : Integer;
begin
aExt := ExtractFileExt(Filename);
Result := ExtractFileName(Filename);
if aExt <> '' then
   begin
   aPos := Pos(aExt,Result);
   if aPos > 0 then
      begin
      Delete(Result,aPos,Length(aExt));
      end;
   end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
AbfWav1.FileName:=DIR_App+'ISO\crunch_voice.wav';
StatusBar1.Panels[0].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
drive:=Copy(DIR_App,Pos(':',DIR_App)-1,2);
end;

procedure TForm1.abfWav1PlayAfter(Sender: TObject);
var
savegame:String;
begin

if (ComboBox1.ItemIndex > 0) then
savegame:='"'+DIR_App+'Class6\Crunch\'+ComboBox1.Text+'.gam"'
else
savegame:=' ';

//-------------------------------------
Sleep(4000);
//-------------------------------------

ShellExecute(Handle,'open',pchar(DIR_App+'ISO\PIXCEL\PIXRUN.exe')
                          ,pchar('"Crunch" '+DIR_App+'ISO '+drive+' "'+savegame+'"'+' 8 96 DEBUG')
                          ,pchar(DIR_App),SW_SHOW);

//-------------------------------------
Sleep(4000);
//-------------------------------------
btn_jogar.Caption:='INICIAR';
Timer1.Enabled:=True;
Form1.Cursor:=crDefault;
end;

procedure TForm1.abfWav1PlayBefore(Sender: TObject);
begin
//--------------------------------
btn_jogar.Caption:='Iniciando...';
btn_jogar.Enabled:=False;
Form1.Cursor:=crHourGlass;
//--------------------------------
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

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Form1.Handle = GetForegroundWindow() then
  Close;
end;

procedure TForm1.Registro1Click(Sender: TObject);
begin
AboutBox.Visible:=True;
Form1.Enabled:=False;
end;

procedure TForm1.ComboBox1Enter(Sender: TObject);
var
i:Integer;
SR:TSearchRec;
Lista:TStringList;
begin
//--------------------------------------------------------------
ComboBox1.Clear;

  Lista:= TStringList.Create;
  i:=FindFirst(drive+'Class6\Crunch\*.gam',faArchive,SR);
  while i = 0 do
  begin
    if (sr.Attr and faArchive) = sr.Attr then
    begin
    Lista.Add(ExtractName(SR.Name))
    end;
    i:=FindNext(SR);
  end;

FindClose(SR);
Lista.Sort;
Lista.Insert(0,'NOVO JOGO');
ComboBox1.Items.Assign(Lista);
ComboBox1.ItemIndex:=0;
Lista.Free;
//--------------------------------------------------------------

end;

procedure TForm1.btn_jogarClick(Sender: TObject);
begin
AbfWav1.Play;
end;

end.
