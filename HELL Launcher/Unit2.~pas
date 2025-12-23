unit Unit2;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellApi, abfControls, pngimage;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    logo: TabfImage;
    SpeedButton1: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
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

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Enabled:=True;
end;

procedure TAboutBox.SpeedButton1Click(Sender: TObject);
begin
Close;
end;

end.
 
