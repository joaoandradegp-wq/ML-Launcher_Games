unit Unit3;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellApi, abfControls, pngimage;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    logo: TabfImage;
    btn_ok: TSpeedButton;
    procedure btn_okClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses Unit1;

{$R *.dfm}

procedure TAboutBox.btn_okClick(Sender: TObject);
begin
Close;
end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Enabled:=True;
end;

end.
 
