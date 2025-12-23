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
    hellcab: TImage;
    btn_jogar: TRxSpeedButton;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Sobre1: TMenuItem;
    abfWav1: TabfWav;
    img_stream: TPanel;
    Timer1: TTimer;
    Panel1: TPanel;
    Image2: TImage;
    Registro1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_jogarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure abfWav1PlayAfter(Sender: TObject);
    procedure abfWav1PlayBefore(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Registro1Click(Sender: TObject);
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

Array_HELL: Array[1..1] of Campos =
(  {JOGO}        {CD}              {CONFIG}           {EXE}
  ('WIN\HELLCAB','ISO\HELLCAB.iso','hell_dosbox.conf','c:\runexit\runexit C:\HELLCAB\HELLCAB.EXE')
);

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
AbfWav1.FileName:=DIR_App+'BIN\hell_voice.wav';
DOSBOX_Config:='BIN\dosbox-0.74.conf';
StatusBar1.Panels[1].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
end;

procedure TForm1.btn_jogarClick(Sender: TObject);
begin
  Try
  CopyFile(PChar(Form1.DIR_App+'BIN\dosbox-0.74.conf'),PChar(Array_HELL[1][3]),True);
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
Arquivo_DOSBOX_Fisico.LoadFromFile(DIR_APP+Array_HELL[1][3]);

   for i:=0 to Arquivo_DOSBOX_Fisico.Count-1 do
   begin
    if Pos('fullscreen=false',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='fullscreen=true';

    if Pos('fullresolution=' ,Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='fullresolution=original';

    if Pos('output=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='output=ddraw';

    if Pos('memsize=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='memsize=32';

    if Pos('aspect=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='aspect=false';

    if Pos('scaler=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='scaler=normal2x';

    if Pos('core=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='core=auto';

    if Pos('cputype=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='cputype=auto';

    if Pos('cycles=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='cycles=max';

    if Pos('cycleup=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='cycleup=1000';

    if Pos('cycledown=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='cycledown=1000';

    if Pos('[autoexec]',Arquivo_DOSBOX_Fisico[i]) = 1 then
    begin
    Arquivo_DOSBOX_Fisico.Add('@ECHO OFF');
    Arquivo_DOSBOX_Fisico.Add('mount c "'+DIR_App+Array_HELL[1][1]+'" -freesize 5000');
    Arquivo_DOSBOX_Fisico.Add('imgmount d "'+DIR_App+Array_HELL[1][2]+'" -t iso');
    Arquivo_DOSBOX_Fisico.Add('c:');
    Arquivo_DOSBOX_Fisico.Add('c:\windows\smartdrv.exe');
    Arquivo_DOSBOX_Fisico.Add('cls');
    Arquivo_DOSBOX_Fisico.Add('SET PATH=%PATH%;C:\WINDOWS;');
    Arquivo_DOSBOX_Fisico.Add('SET TEMP=C:\WINDOWS\TEMP');
    Arquivo_DOSBOX_Fisico.Add('lh devlod C:\SB16\DRV\CSP.SYS /UNIT=0 /BLASTER=A:220');
    Arquivo_DOSBOX_Fisico.Add('lh devlod C:\SB16\DRV\CTMMSYS.SYS');
    Arquivo_DOSBOX_Fisico.Add('SET SOUND=C:\SB16');
    Arquivo_DOSBOX_Fisico.Add('SET BLASTER=A220 I7 D1 H5 P330 T6');
    Arquivo_DOSBOX_Fisico.Add('SET MIDI=SYNTH:1 MAP:E');
    Arquivo_DOSBOX_Fisico.Add('C:\SB16\MIXERSET /P /Q');
    Arquivo_DOSBOX_Fisico.Add('win '+Array_HELL[1][4]);
    Arquivo_DOSBOX_Fisico.Add('Exit.');
    end;

   end;

Arquivo_DOSBOX_Fisico.SaveToFile(DIR_APP+Array_HELL[1][3]);
Arquivo_DOSBOX_Fisico.Free;

ShellExecute(Handle,'open',pchar(DIR_App+'BIN\DOSBox.exe')
                          ,pchar('-conf '+Array_HELL[1][3]+' -noconsole -c "exit"')
                          ,pchar(DIR_App),SW_HIDE);

//-------------------------------------
Sleep(4000);
//-------------------------------------
btn_jogar.Caption:='INICIAR';
Timer1.Enabled:=True;
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

procedure TForm1.FormDestroy(Sender: TObject);
begin
DeleteFile(DIR_App+Array_HELL[1][3]);
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

procedure TForm1.Registro1Click(Sender: TObject);
begin
AboutBox.Visible:=True;
Form1.Enabled:=False;
end;

end.
