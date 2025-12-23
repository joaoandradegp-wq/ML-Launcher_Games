unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ShellApi, pngimage, RXCtrls, ComCtrls,
  Menus, abfComponents, abfControls, RXSwitch, DateUtils;

type
//------------------------------------
Campos = Array[1..4] of String;
//------------------------------------

type
  TForm1 = class(TForm)
    alone1: TImage;
    alone2: TImage;
    alone3: TImage;
    SELECT: TImage;
    btn_jogar: TRxSpeedButton;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Sobre1: TMenuItem;
    alone2_bonus: TImage;
    abfWav1: TabfWav;
    Image1: TImage;
    Panel1: TPanel;
    Registro1: TMenuItem;
    procedure alone1Click(Sender: TObject);
    procedure alone2Click(Sender: TObject);
    procedure alone3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_jogarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure SELECTDblClick(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Registro1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  Fecha_ESC,AITD3_Language:Boolean;

const

Array_AITD: Array[1..4] of Campos =
(  {JOGO}             {CD}                       {CONFIG}            {EXE}
  ('INFOGRAM\INDARK' ,'ISO\ALONE1\ALONECD.cue'  ,'aitd1_dosbox.conf','INDARK.exe'),
  ('INFOGRAM\INDARK2','ISO\ALONE2\AITD2.cue'    ,'aitd2_dosbox.conf','AITD2.exe'),
  ('INFOGRAM\INDARK3','ISO\ALONE3\AITD3.cue'    ,'aitd3_dosbox.conf','AITD3.exe'),

  ('INFOGRAM\INDARK2\JACKDARK','ISO\ALONE2\AITD2.cue'    ,'aitd2b_dosbox.conf','indark2.exe 16 1')
//('I-MOTION\INDARK3'         ,'ISO\ALONE3_ENG\AITD3.cue','aitd3e_dosbox.conf','AITD3.exe')
);

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure Selecao(Game:Integer);
var
i:Integer;
begin
Form1.btn_jogar.Caption:='ALONE IN THE DARK';

  for i:=1 to Length(Array_AITD) do
  DeleteFile(Form1.DIR_App+Array_AITD[i][3]);

  case Game of
  1: begin
     Form1.SELECT.Left:=Form1.alone1.Left;
     Form1.id:=1;
     end;
  2: begin
     Form1.SELECT.Left:=Form1.alone2.Left;
     Form1.id:=2;
     end;
  3: begin
     Form1.SELECT.Left:=Form1.alone3.Left;
     Form1.id:=3;
     end;
  4: begin
       if (Form1.SELECT.Left = Form1.alone2.Left) then
       begin
       Form1.id:=4;
       Form1.alone2_bonus.Left:=Form1.alone2.Left;
       Form1.alone2_bonus.Visible:=True;
       Form1.btn_jogar.Caption:='JACK IN THE DARK';
       end;
     end;
  end;

CopyFile(PChar(Form1.DIR_App+'BIN\dosbox-0.74.conf'),PChar(Array_AITD[Form1.id][3]),True);
Form1.SELECT.Visible:=True;
Form1.btn_jogar.Enabled:=True;

 if (Game = 1) or (Game = 3) then
 Form1.alone2_bonus.Visible:=False;
 
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
AbfWav1.FileName:=DIR_App+'BIN\alone_voice.wav'; 
DOSBOX_Config:='BIN\dosbox-0.74.conf';
StatusBar1.Panels[1].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
end;

procedure TForm1.alone1Click(Sender: TObject);
begin
Selecao(1);
end;

procedure TForm1.alone2Click(Sender: TObject);
begin
Selecao(2);
end;

procedure TForm1.alone3Click(Sender: TObject);
begin
Selecao(3);
end;

procedure TForm1.SELECTDblClick(Sender: TObject);
begin
Selecao(4);
end;

procedure TForm1.btn_jogarClick(Sender: TObject);
var
i:Integer;
AIDT3_ENG:String;
begin
//-------------------------------------
btn_jogar.Caption:='Iniciando...';
btn_jogar.Enabled:=False;
Form1.Cursor:=crHourGlass;
//-------------------------------------

Arquivo_DOSBOX_Fisico:=TStringList.Create;
Arquivo_DOSBOX_Fisico.LoadFromFile(DIR_APP+Array_AITD[id][3]);

   for i:=0 to Arquivo_DOSBOX_Fisico.Count-1 do
   begin
    if Pos('fullscreen=false',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='fullscreen=true';

    if Pos('fullresolution=' ,Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='fullresolution=desktop';

    if Pos('aspect=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='aspect=false';

    if Pos('core=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    Arquivo_DOSBOX_Fisico[i]:='core=dynamic';

    if Pos('cputype=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    begin
      if id = 1 then
      Arquivo_DOSBOX_Fisico[i]:='cputype=pentium_slow'
      else
      Arquivo_DOSBOX_Fisico[i]:='cputype=486_slow';
    end;

    if Pos('cycles=',Arquivo_DOSBOX_Fisico[i]) = 1 then
    begin
      case id of
      1: Arquivo_DOSBOX_Fisico[i]:='cycles=12000';
      2: Arquivo_DOSBOX_Fisico[i]:='cycles=19000';
      3: Arquivo_DOSBOX_Fisico[i]:='cycles=26000';
      end;
    end;

    if Pos('[autoexec]',Arquivo_DOSBOX_Fisico[i]) = 1 then
    begin
    Arquivo_DOSBOX_Fisico.Add('@ECHO OFF');
    Arquivo_DOSBOX_Fisico.Add('mount c "'+DIR_App+Array_AITD[id][1]+'"');

      if id = 3 then
      begin
      AIDT3_ENG:='imgmount d "'+DIR_App+'ISO\ALONE3_ENG\AITD3.cue'+'" -t cdrom';

      Application.CreateForm(TForm3, Form3);
      Form3.ShowModal;
      Form3.Free;

        if AITD3_Language = True then
        Arquivo_DOSBOX_Fisico.Add('imgmount d "'+DIR_App+Array_AITD[id][2]+'" -t cdrom')
        else
        Arquivo_DOSBOX_Fisico.Add(AIDT3_ENG);

      //----------------------
      if Fecha_ESC = True then
      Exit;
      //----------------------
      end
      else
      Arquivo_DOSBOX_Fisico.Add('imgmount d "'+DIR_App+Array_AITD[id][2]+'" -t cdrom');

    Arquivo_DOSBOX_Fisico.Add('c:');
    Arquivo_DOSBOX_Fisico.Add('cls');
    Arquivo_DOSBOX_Fisico.Add(Array_AITD[id][4]);
    Arquivo_DOSBOX_Fisico.Add('Exit.');
    end;

   end;

Arquivo_DOSBOX_Fisico.SaveToFile(DIR_APP+Array_AITD[id][3]);
Arquivo_DOSBOX_Fisico.Free;

AbfWav1.Play;
//-------------------------------------
Sleep(4000);
//-------------------------------------

ShellExecute(Handle,'open',pchar(DIR_App+'BIN\DOSBox.exe')
                          ,pchar('-conf '+Array_AITD[id][3]+' -noconsole -c "exit"')
                          ,pchar(DIR_App),SW_HIDE);

//-------------------------------------
Sleep(4000);
//-------------------------------------
btn_jogar.Caption:='ALONE IN THE DARK';
btn_jogar.Enabled:=True;
Form1.Cursor:=crDefault;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
if id <> 0 then
DeleteFile(DIR_App+Array_AITD[id][3]);

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

procedure TForm1.FormCreate(Sender: TObject);
begin
 Font.Name := 'Segoe UI';
 Font.Size := 10;
end;

end.
