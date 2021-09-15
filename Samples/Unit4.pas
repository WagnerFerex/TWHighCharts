unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, DBrCharts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TForm4 = class(TForm)
    WebBrowser1: TWebBrowser;
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses
  System.Win.Registry, System.JSON, StrUtils;

{$R *.dfm}


procedure TForm4.FormActivate(Sender: TObject);
begin
  TDBrWebCharts.New
    .WebBrowser(WebBrowser1)
    .DataSet(FDQuery1)
    .Pizza('Quantidade de Inscritos por Status');
end;

end.
