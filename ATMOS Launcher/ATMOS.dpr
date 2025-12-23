program ATMOS;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Cards},
  Unit3 in 'Unit3.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ATMOS LAUNCHER 1.5';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
