program CRUNCH;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit3 in 'Unit3.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CRUNCH LAUNCHER 1.0';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
