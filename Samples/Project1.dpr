program Project1;

uses
  Vcl.Forms,
  Unit4 in 'Unit4.pas' {Form4},
  DBrCharts in '..\DBrCharts.pas',
  DBrCharts.Types in '..\DBrCharts.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
