unit DBrCharts;

interface

uses
  Vcl.OleCtrls, SHDocVw, Data.DB, DBrCharts.Types;

type
  IDBrCharts = interface;

  IDBrWebCharts = interface
    ['{ADB43D9F-9D88-4BB2-96AD-B0790EFA3E84}']
//    function Pizza(Caption: string; DataSet: string): IDBrCharts;
//    function Charts: IDBrCharts;
//    function WebBrowser(WebBrowser: TWebBrowser): IDBrWebCharts;
//    function Generated: IDBrWebCharts;

    function Pizza(Caption: string): IDBrWebCharts;
    function WebBrowser(WebBrowser: TWebBrowser): IDBrWebCharts;
    function DataSet(DataSet: TDataSet): IDBrWebCharts;
    function Generated: IDBrWebCharts;
  end;



  IDBrCharts = interface
    ['{573ED4B0-AB50-4E6F-B604-35584D92711A}']
    function _ChartType(TypeChart: TTypeChart): IDBrCharts;
    function &End: IDBrWebCharts;
  end;


  TDBrWebCharts = class(TInterfacedObject, IDBrWebCharts)
  private
    FWebBrowser: TWebBrowser;
    FDataSet: TDataSet;
    procedure EditText(CONST HTMLCode: string);
    function DataSetToDataCharts(DataSet: TDataSet; FieldName, FieldValue: string): string;
  public
    constructor Create;
    class function New: IDBrWebCharts;
    function Pizza(Caption: string): IDBrWebCharts;
    function WebBrowser(WebBrowser: TWebBrowser): IDBrWebCharts;
    function DataSet(DataSet: TDataSet): IDBrWebCharts;
    function Generated: IDBrWebCharts;
  end;

implementation

uses
  System.Win.Registry, System.SysUtils, Winapi.Windows, System.StrUtils;

{ TDBrWebCharts }

constructor TDBrWebCharts.Create;
begin

end;

function TDBrWebCharts.DataSet(DataSet: TDataSet): IDBrWebCharts;
begin
  Result := Self;
  FDataSet := DataSet;
end;

function TDBrWebCharts.DataSetToDataCharts(DataSet: TDataSet; FieldName, FieldValue: string): string;
begin
  DataSet.Active := True;
  DataSet.First;
  while not DataSet.Eof do
  begin
    Result := Result + ifThen(not Result.IsEmpty, ',') + Format('{name:''%s'', y:%d }', [
      DataSet.FieldByName(FieldName).AsString,
      DataSet.FieldByName(FieldValue).AsInteger]);
    DataSet.Next;
  end;
end;

procedure TDBrWebCharts.EditText(const HTMLCode: string);
var
  Doc: Variant;
begin
  if not
   Assigned(FWebBrowser.Document) then
    FWebBrowser.Navigate('about:blank');

  Doc := FWebBrowser.Document;
  Doc.Clear;
  Doc.Write(HTMLCode);
  Doc.Close;
end;

function TDBrWebCharts.Generated: IDBrWebCharts;
begin
  Result := Self;

end;

class function TDBrWebCharts.New: IDBrWebCharts;
begin
  Result := Self.Create;
end;

function TDBrWebCharts.Pizza(Caption: string): IDBrWebCharts;
begin
  Result := Self;
  EditText(
    '<html> '+
    '<head> '+
    '  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> '+
    '  <script src="https://code.highcharts.com/highcharts.js"></script> '+
    '</head> '+
    '<body> '+
    '  <div id="container"></div> '+
    '  <script> '+
    '  $(''document'').ready(function(){ '+
    '    Highcharts.chart(''container'', { '+
    '    chart: { '+
    '      plotBackgroundColor: null, '+
    '      plotBorderWidth: null, '+
    '      plotShadow: false, '+
    '      type: ''pie'' '+
    '    }, '+
    '    title: { '+
    '    text: '''+ Caption  +''' ' +
    '  }, '+
    'credits: { '+
    'enabled: false '+
    '}, '+
    'tooltip: { '+
    'pointFormat: ''{series.name}: <b>{point.percentage:.1f}%</b>'' '+
    '}, '+
    'accessibility: { '+
    'point: { '+
    'valueSuffix: ''%'' '+
    '} '+
    '}, '+
    'plotOptions: { '+
    'pie: { '+
    'allowPointSelect: true, '+
    'cursor: ''pointer'', '+
    'dataLabels: { '+
    'enabled: true, '+
    'format: ''<b>{point.name}</b>: {point.percentage:.1f} %'' '+
    '} '+
    '} '+
    '}, '+
    'series: [{ '+
    'name: ''Brands'', '+
    'colorByPoint: true, '+
    'data: ['+
      DataSetToDataCharts(FDataSet) +
    '] '+
    '}] '+
    '}); '+
    '}); '+
    '  </script> '+
    '</body> '+
    '</html> '
  );
end;

function TDBrWebCharts.WebBrowser(WebBrowser: TWebBrowser): IDBrWebCharts;
begin
  Result := Self;
  FWebBrowser := WebBrowser;
end;

procedure RegisterWebBrowserIEv11;
var
  Reg: TRegistry;
  AppName: String;
begin
  AppName := ExtractFileName(ExtractFileName(ParamStr(0)));
  Reg := nil;
  try
    Reg := TRegistry.Create();
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION', True) then
    begin
      Reg.WriteInteger(AppName, 11000);
      Reg.CloseKey;
    end;
  except;
  end;
  if Assigned(Reg) then FreeAndNil(Reg);
end;

initialization
  RegisterWebBrowserIEv11;

end.
