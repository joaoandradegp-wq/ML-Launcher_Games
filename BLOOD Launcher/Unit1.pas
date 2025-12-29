unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ShellApi, pngimage, RXCtrls, ComCtrls,
  Menus, abfComponents, DateUtils;

type
//------------------------------------
Campos = Array[1..3] of String;
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
    Panel1: TPanel;
    Image2: TImage;
    Registro1: TMenuItem;
    abfFolderMonitor1: TabfFolderMonitor;
    cryptic: TImage;
    blood: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_jogarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure abfWav1PlayAfter(Sender: TObject);
    procedure abfWav1PlayBefore(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Registro1Click(Sender: TObject);
    procedure bloodDblClick(Sender: TObject);
    procedure crypticDblClick(Sender: TObject);
  private
    { Private declarations }
  public
  id:Integer;
  DIR_App,DOSBOX_Config:String;
  Arquivo_DOSBOX_Fisico:TStringList;
    { Public declarations }
  end;

var
  Form1: TForm1;

const

Array_BLOOD: Array[1..3] of Campos =
(  {PASTA}  {CONFIG}                    {EXE}
   ('BLOOD','BLOOD\blood_dosbox.conf'  ,'BLOOD.exe  '),
   ('BLOOD','BLOOD\cryptic_dosbox.conf','CRYPTIC.exe'),
   ('BLOOD','BLOOD\setup_dosbox.conf'  ,'SETUP.exe'  )
);

implementation

uses Unit2;

{$R *.dfm}

procedure Selecao(Game:Integer);
var
i:Integer;
begin
Form1.id:=Game;

  for i:=1 to Length(Array_BLOOD) do
  DeleteFile(Form1.DIR_App+Array_BLOOD[i][2]);

  case Game of
    1: Form1.btn_jogar.Caption:='ONE UNIT: WHOLE BLOOD';
    2: Form1.btn_jogar.Caption:='CRYPTIC PASSAGE';
  end;

  Try
  CopyFile(PChar(Form1.DIR_App+'BIN\dosbox-0.74-blood.conf'),PChar(Array_BLOOD[Game][2]),True);
  Finally
  Form1.btn_jogar.Enabled:=True;
  end;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
AbfWav1.FileName:=DIR_App+'BIN\blood_voice.wav';
DOSBOX_Config:='BIN\dosbox-0.74-blood.conf';
StatusBar1.Panels[1].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
Selecao(1);
end;

procedure TForm1.btn_jogarClick(Sender: TObject);
begin
  if blood.Visible = True then
  Selecao(1)
  else
  Selecao(2);

AbfWav1.Play;
end;

procedure TForm1.abfWav1PlayAfter(Sender: TObject);
var
i:Integer;
begin
Sleep(4000);

Arquivo_DOSBOX_Fisico:=TStringList.Create;
Arquivo_DOSBOX_Fisico.LoadFromFile(DIR_APP+Array_BLOOD[id][2]);

   for i:=0 to Arquivo_DOSBOX_Fisico.Count-1 do
   begin
    if Pos('fullscreen=false',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='fullscreen=true';

    if Pos('fullresolution=' ,Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='fullresolution=desktop';

    if Pos('[autoexec]',Arquivo_DOSBOX_Fisico[i]) = 1 then
    begin
    Arquivo_DOSBOX_Fisico.Add('@ECHO OFF');
    Arquivo_DOSBOX_Fisico.Add('mount c "'+DIR_App+Array_BLOOD[id][1]+'"');
    Arquivo_DOSBOX_Fisico.Add('c:');
    Arquivo_DOSBOX_Fisico.Add('imgmount D game.ins -t iso');
    Arquivo_DOSBOX_Fisico.Add('cls');
    Arquivo_DOSBOX_Fisico.Add(Array_BLOOD[id][3]);
    Arquivo_DOSBOX_Fisico.Add('Exit.');
    end;

   end;

Arquivo_DOSBOX_Fisico.SaveToFile(DIR_APP+Array_BLOOD[id][2]);
Arquivo_DOSBOX_Fisico.Free;

ShellExecute(Handle,'open',pchar(DIR_App+'BIN\DOSBox.exe')
                          ,pchar('-conf '+Array_BLOOD[id][2]+' -noconsole -c "exit"')
                          ,pchar(DIR_App),SW_SHOW);

//----------------------------
Sleep(6000);
//----------------------------
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

procedure TForm1.FormDestroy(Sender: TObject);
begin
if id <> 0 then
DeleteFile(DIR_App+Array_BLOOD[id][2]);

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

procedure TForm1.Registro1Click(Sender: TObject);
begin
AboutBox.Visible:=True;
Form1.Enabled:=False;
end;

procedure TForm1.bloodDblClick(Sender: TObject);
begin
blood.Visible:=False;
cryptic.Visible:=True;
Selecao(2);
end;

procedure TForm1.crypticDblClick(Sender: TObject);
begin
blood.Visible:=True;
cryptic.Visible:=False;
Selecao(1);
end;

end.

