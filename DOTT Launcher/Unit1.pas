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
    maniac: TImage;
    dott: TImage;
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
    procedure maniacClick(Sender: TObject);
    procedure dottClick(Sender: TObject);
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

Array_MMDAY: Array[1..2] of Campos =
(
  ('LUCAS\MM'           ,'MANIAC'  ),
  ('LUCAS\DOTT\tentacle','tentacle')
);

implementation

uses Unit2;

{$R *.dfm}

procedure Selecao(Game:Integer);
begin
Form1.id:=Game;
Form1.btn_jogar.Caption:='LUCAS ARTS';

  case Game of
  1: begin
     Form1.SELECT.Left:=Form1.maniac.Left;
     Form1.btn_jogar.Caption:='MANIAC MANSION';
     end;
  2: begin
     Form1.SELECT.Left:=Form1.dott.Left;
     Form1.btn_jogar.Caption:='DAY OF THE TENTACLE';
     end;
  end;

Form1.SELECT.Visible:=True;
Form1.btn_jogar.Enabled:=True;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Caption:=Application.Title;
DIR_App:=ExtractFilePath(Application.ExeName);
StatusBar1.Panels[1].Text:='© '+IntToStr(YearOf(Date))+', JMBA Softwares. Todos os direitos reservados.';
end;

procedure TForm1.maniacClick(Sender: TObject);
begin
AbfWav1.FileName:=DIR_App+'BIN\mmd_voice.wav';
Selecao(1);
end;

procedure TForm1.dottClick(Sender: TObject);
begin
AbfWav1.FileName:=DIR_App+'BIN\tentacle_voice.wav';
Selecao(2);
end;

procedure TForm1.btn_jogarClick(Sender: TObject);
begin
AbfWav1.Play;
end;

procedure TForm1.abfWav1PlayAfter(Sender: TObject);
begin

  case id of
  1: begin
     Sleep(1000);
     ShellExecute(Handle,'open',pchar('"'+DIR_App+'LUCAS\MMD\Maniac.exe'+'"'),''
                         ,pchar(DIR_App+'LUCAS\MMD'),SW_SHOW);
     end;
  2: begin
     Sleep(5000);
     ShellExecute(Handle,'open',pchar('"'+DIR_App+'BIN\scummvm.exe'+'"')
                        ,pchar('-f -n -c"'+DIR_App+Array_MMDAY[id][1]+'\scumm.ini"'+' -p"'+DIR_App+Array_MMDAY[id][1]+'" '+Array_MMDAY[id][2])
                        ,pchar(DIR_App)
                        ,SW_HIDE);
     end;
  end;

//-------------------------------------
Sleep(4000);
//-------------------------------------
btn_jogar.Caption:='LUCAS ARTS';
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
