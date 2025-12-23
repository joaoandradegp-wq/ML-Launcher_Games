unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ShellAPI, abfComponents;

type
  TCards = class(TForm)
    Personagem: TImage;
    A1: TImage;
    A2: TImage;
    A3: TImage;
    A4: TImage;
    A5: TImage;
    A6: TImage;
    Wav: TabfWav;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure A1DblClick(Sender: TObject);
    procedure A2DblClick(Sender: TObject);
    procedure A3DblClick(Sender: TObject);
    procedure A4DblClick(Sender: TObject);
    procedure A5DblClick(Sender: TObject);
    procedure A6DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cards: TCards;

implementation

uses Unit1;

{$R *.dfm}

function AtmosCards(card:Integer):Boolean;
var
Caminho:String;
begin
Caminho:=ExtractFileDir(Application.ExeName)+'\CARDS\0'+IntToStr(card)+'.pdf';
Cards.Wav.Stop;
Result:=False;

 case ShellExecute(Application.Handle,'open',PChar(''+Caminho),'','',SW_SHOWMAXIMIZED) of
  2: begin
     Application.MessageBox('Cartão de referência não encontrado!'  ,PChar(Application.Title),MB_ICONERROR+MB_OK);
     Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\AT_0472C.wav';
     Cards.Wav.Play;
     end;
 31: begin
     Application.MessageBox('Necessário um leitor de PDF instalado.',PChar(Application.Title),MB_ICONINFORMATION+MB_OK);
     Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\AT_0426.wav';
     Cards.Wav.Play;
     end;
 else
 begin
   case card of
   1: Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\BJUJU2.wav';
   2: Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\BATS.wav';
   3: Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\WITCH.wav';
   4: Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\EGYPT.wav';
   5: Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\HELEN.wav';
   6: Cards.Wav.FileName:=Form1.DIR_App+'ISO\ATMOSFEAR\INSTALL\HOWL.wav';
   end;
 Cards.Wav.Play;
 Result:=True;
 end;
 end;

end;

procedure TCards.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (key = #27) then
Close;
end;

procedure TCards.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cards.Release;
Cards:=Nil;
end;

procedure TCards.A1DblClick(Sender: TObject);
begin
AtmosCards(1);
end;

procedure TCards.A2DblClick(Sender: TObject);
begin
AtmosCards(2);
end;

procedure TCards.A3DblClick(Sender: TObject);
begin
AtmosCards(3);
end;

procedure TCards.A4DblClick(Sender: TObject);
begin
AtmosCards(4);
end;

procedure TCards.A5DblClick(Sender: TObject);
begin
AtmosCards(5);
end;

procedure TCards.A6DblClick(Sender: TObject);
begin
AtmosCards(6);
end;

end.
