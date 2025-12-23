unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ShellApi, pngimage, RXCtrls, ComCtrls,
  Menus, abfComponents, DateUtils;

type
//------------------------------------
Campos = Array[1..4] of String;
//------------------------------------

type
  TForm1 = class(TForm)
    tcm: TImage;
    btn_jogar: TRxSpeedButton;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Sobre1: TMenuItem;
    abfWav1: TabfWav;
    Panel1: TPanel;
    Image2: TImage;
    Timer1: TTimer;
    Registrp1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_jogarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure abfWav1PlayAfter(Sender: TObject);
    procedure abfWav1PlayBefore(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Registrp1Click(Sender: TObject);
  private
    { Private declarations }
  public
  DIR_App,DOSBOX_Config:String;
  Arquivo_DOSBOX_Fisico:TStringList;
    { Public declarations }
  end;

var
  Form1: TForm1;

const

Array_TWI: Array[1..1] of Campos =
(  {JOGO}    {CD}              {CONFIG}              {EXE}
  ('TWINSEN','ISO\TWINSEN.CUE','twinsen_dosbox.conf','TWINSEN.exe')
);

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
AbfWav1.FileName:=DIR_App+'BIN\to_voice.wav';
DOSBOX_Config:='BIN\dosbox-0.74.conf';
StatusBar1.Panels[1].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
end;

procedure TForm1.btn_jogarClick(Sender: TObject);
begin
  Try
  CopyFile(PChar(Form1.DIR_App+'BIN\dosbox-0.74.conf'),PChar(Array_TWI[1][3]),True);
  Finally
  AbfWav1.Play;
  end;
end;

procedure TForm1.abfWav1PlayAfter(Sender: TObject);
var
i:Integer;
begin
//-------------------------------------
Sleep(4000);
//-------------------------------------

Arquivo_DOSBOX_Fisico:=TStringList.Create;
Arquivo_DOSBOX_Fisico.LoadFromFile(DIR_APP+Array_TWI[1][3]);

   for i:=0 to Arquivo_DOSBOX_Fisico.Count-1 do
   begin

    {[sdl]}
    if Pos('fullscreen=false',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='fullscreen=true';

    {[dosbox]}
    if Pos('memsize=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='memsize=30';

    {[cpu]}
    if Pos('core=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='core=auto';
    if Pos('cycleup=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='cycleup=5000';
    if Pos('cycledown=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='cycledown=5000';

    {[mixer]}
    if Pos('rate=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='rate=22050';
    if Pos('blocksize=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='blocksize=2048';
    if Pos('prebuffer=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='prebuffer=10';

    {[sblaster]}
    if Pos('oplrate=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='oplrate=22050';

    {[speaker]}
    if Pos('pcrate=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='pcrate=22050';
    if Pos('tandyrate=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='tandyrate=22050';

    {[joystick]}
    if Pos('buttonwrap=false',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='buttonwrap=true';

    {dos}
    if Pos('keyboardlayout=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='keyboardlayout=none';

    if Pos('[autoexec]',Arquivo_DOSBOX_Fisico[i]) = 1 then
    begin
    Arquivo_DOSBOX_Fisico.Add('@ECHO OFF');
    Arquivo_DOSBOX_Fisico.Add('mount c "'   +DIR_App+Array_TWI[1][1]+'"');
    Arquivo_DOSBOX_Fisico.Add('imgmount d "'+DIR_App+Array_TWI[1][2]+'" -t iso');
    Arquivo_DOSBOX_Fisico.Add('c:');
    Arquivo_DOSBOX_Fisico.Add('cls');
    Arquivo_DOSBOX_Fisico.Add(Array_TWI[1][4]);
    Arquivo_DOSBOX_Fisico.Add('Exit.');
    end;

   end;

Arquivo_DOSBOX_Fisico.SaveToFile(DIR_APP+Array_TWI[1][3]);
Arquivo_DOSBOX_Fisico.Free;

ShellExecute(Handle,'open',pchar(DIR_App+'BIN\DOSBox.exe')
                          ,pchar('-conf '+Array_TWI[1][3]+' -noconsole -c "exit"')
                          ,pchar(DIR_App),SW_HIDE);

//-------------------------------------
Sleep(4000);
//-------------------------------------
btn_jogar.Caption:='INICIAR';
Form1.Cursor:=crDefault;
Timer1.Enabled:=True;
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

procedure TForm1.FormDestroy(Sender: TObject);
begin
DeleteFile(DIR_App+Array_TWI[1][3]);
DeleteFile('stdout.txt');
DeleteFile('stderr.txt');
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

procedure TForm1.Registrp1Click(Sender: TObject);
begin
AboutBox.Visible:=True;
Form1.Enabled:=False;
end;

end.
