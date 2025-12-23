unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, pngimage, ExtCtrls, abfControls;

type
  TForm3 = class(TForm)
    abfImage1: TabfImage;
    Bevel1: TBevel;
    Image1: TImage;
    Image2: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}

procedure CancelaAITD3;
begin
  Form1.btn_jogar.Caption:='ALONE IN THE DARK';
  Form1.btn_jogar.Enabled:=True;
  Form1.Cursor:=crDefault;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form3.Release;
Form3:=Nil;
end;

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if (key = #27) then
  begin
  Close;
  Fecha_ESC:=True;
  CancelaAITD3;
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
 Font.Name := 'Segoe UI';
 Font.Size := 10;
end;

procedure TForm3.Image1Click(Sender: TObject);
begin
AITD3_Language:=True;
Close;
end;

procedure TForm3.Image2Click(Sender: TObject);
begin
AITD3_Language:=False;
Close;
end;

end.
