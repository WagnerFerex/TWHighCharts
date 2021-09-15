object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 610
  ClientWidth = 958
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 8
    Top = 8
    Width = 942
    Height = 594
    TabOrder = 0
    ControlData = {
      4C0000005C610000643D00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select x.Status, count(1) QtdEscola, sum(EstimativaTempo) Estima' +
        'tivaTempo, sum(Inscricoes) Inscricoes'
      'from ('
      
        #9'select lp.CodLocalProva, lp.NomeLocalProva, lp.CodPredio, lp.Pr' +
        'edio, lp.UF, lp.Municipio, case  when lp.Liberado = '#39'S'#39' and lp.S' +
        'tatus = '#39'PENDENTE'#39' then '#39'LIBERADO'#39' else lp.Status end [Status], ' +
        'lp.Inicio, lp.Fim,'
      
        #9#9'count(ce.CodInscricao) Digitalizados, count(a.CodInscricao) In' +
        'scricoes, '
      
        #9#9'cast((cast(count(a.CodInscricao) as float) * 2.5) as numeric(1' +
        '0,4)) EstimativaTempo'
      #9'from Alocacao a'
      
        #9'inner join AlocacaoLocalProva lp on lp.CodLocalProva = a.CodLoc' +
        'alProva and lp.CodPredio = a.CodPredio'
      
        #9'left join ControleExibicao ce on ce.CodInscricao = a.CodInscric' +
        'ao'
      
        '        inner join Resultado r on r.CodInscricao = a.CodInscrica' +
        'o '
      '        where r.Situacao not like '#39'%ausente%'#39
      
        #9'group by lp.CodLocalProva, lp.NomeLocalProva, lp.CodPredio, lp.' +
        'Predio, lp.UF, lp.Municipio, lp.Status, lp.Liberado, lp.Inicio, ' +
        'lp.Fim)x'
      'group by Status')
    Left = 824
    Top = 120
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ApplicationName=SistemaDPGE'
      'User_Name=sa'
      'Password=Estudar11!'
      'Database=Sistema'
      'Server=10.2.20.32'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 824
    Top = 80
  end
end
