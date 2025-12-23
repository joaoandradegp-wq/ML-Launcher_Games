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
    indiana1: TImage;
    indiana2: TImage;
    SELECT: TImage;
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
    procedure indiana1Click(Sender: TObject);
    procedure indiana2Click(Sender: TObject);
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
  id:Integer;
  DIR_App:String;
    { Public declarations }
  end;

var
  Form1: TForm1;

const

Array_LARTS: Array[1..2] of Campos =
(
  ('LUCAS\crusade' ,'indy3' ),
  ('LUCAS\atlantis','atlantis')
);

implementation

uses Unit2;

{$R *.dfm}

procedure Selecao(Game:Integer);
begin
Form1.id:=Game;

  case Game of
  1: begin
     Form1.SELECT.Left:=Form1.indiana1.Left;
     Form1.btn_jogar.Caption:='LAST CRUSADE';
     end;
  2: begin
     Form1.SELECT.Left:=Form1.indiana2.Left;
     Form1.btn_jogar.Caption:='FATE OF ATLANTIS';
     end;
  end;

Form1.SELECT.Visible:=True;
Form1.btn_jogar.Enabled:=True;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
AbfWav1.FileName:=DIR_App+'BIN\indiana_voice.wav';
StatusBar1.Panels[1].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
end;

procedure TForm1.indiana1Click(Sender: TObject);
begin
Selecao(1);
end;

procedure TForm1.indiana2Click(Sender: TObject);
begin
Selecao(2);
end;

procedure TForm1.btn_jogarClick(Sender: TObject);
begin
AbfWav1.Play;
end;

procedure TForm1.abfWav1PlayAfter(Sender: TObject);
begin
//-------------------------------------
Sleep(4000);
//-------------------------------------

ShellExecute(Handle,'open',pchar('"'+DIR_App+'BIN\scummvm.exe'+'"')
                          ,pchar('-f -n -c"'+DIR_App+Array_LARTS[id][1]+'\scumm.ini"'+' -p"'+DIR_App+Array_LARTS[id][1]+'" '+Array_LARTS[id][2])
                          ,pchar(DIR_App)
                          ,SW_HIDE);

//-------------------------------------
Sleep(4000);
//-------------------------------------
btn_jogar.Caption:='INICIAR';
SELECT.Visible:=False;
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
