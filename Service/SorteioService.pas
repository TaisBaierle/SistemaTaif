unit SorteioService;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  SistemaSorteioData;

type
  TSorteioService = class
  public
    function ExecutarSorteio: TFDQuery;
    procedure ExcluirVendasNaoSorteadas;
  end;

implementation

function TSorteioService.ExecutarSorteio: TFDQuery;
var
  qrSorteio: TFDQuery;
begin
  qrSorteio := dmSistemaSorteio.ExecutarSql('SELECT FIRST 15 ' +
    '  C.IDCLIENTE, ' + '  C.NOME, ' + '  C.CPFCNPJ, ' +
    '  MIN(CA.DATALANCAMENTO) AS DATALANCAMENTO ' + 'FROM CLIENTE C ' +
    'JOIN VENDA V ON V.IDCLIENTE = C.IDCLIENTE ' +
    'JOIN CARRO CA ON CA.IDCARRO = V.IDCARRO ' +
    'WHERE C.CPFCNPJ STARTING WITH ''0'' ' +
    '  AND EXTRACT(YEAR FROM CA.DATALANCAMENTO) = 2021 ' + 'GROUP BY ' +
    '  C.IDCLIENTE, ' + '  C.NOME, ' + '  C.CPFCNPJ ' +
    'HAVING SUM(CASE WHEN CA.MODELO = ''MAREA'' THEN 1 ELSE 0 END) < 2 ' +
    'ORDER BY DATALANCAMENTO', True);

  Result := qrSorteio;

end;

procedure TSorteioService.ExcluirVendasNaoSorteadas;
begin
  dmSistemaSorteio.ExecutarSql('DELETE FROM VENDA V ' + 'WHERE NOT EXISTS ( ' +
    '  SELECT 1 ' + '  FROM CLIENTE C ' +
    '  JOIN VENDA V2 ON V2.IDCLIENTE = C.IDCLIENTE ' +
    '  JOIN CARRO CA ON CA.IDCARRO = V2.IDCARRO ' +
    '  WHERE C.IDCLIENTE = V.IDCLIENTE ' +
    '    AND C.CPFCNPJ STARTING WITH ''0'' ' +
    '    AND EXTRACT(YEAR FROM CA.DATALANCAMENTO) = 2021 ' + '    AND ( ' +
    '      SELECT COUNT(*) ' + '      FROM VENDA V3 ' +
    '      JOIN CARRO CA3 ON CA3.IDCARRO = V3.IDCARRO ' +
    '      WHERE V3.IDCLIENTE = C.IDCLIENTE ' +
    '        AND CA3.MODELO = ''MAREA'' ' + '    ) < 2 ' + '  )', False);
end;

end.
