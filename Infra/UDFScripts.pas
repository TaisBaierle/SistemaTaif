unit UDFScripts;

interface

procedure CriarEstruturaBanco;

implementation

uses
  FireDAC.Comp.Client, SysUtils, SistemaSorteioData;

procedure CriarEstruturaBanco;
const
  SQLCLIENTE = 'CREATE TABLE CLIENTE (IDCLIENTE INTEGER NOT NULL,' +
    '  NOME VARCHAR(4096), CPFCNPJ VARCHAR(14), DATACADASTRO DATE,'
    + '  CONSTRAINT PK_CLIENTE PRIMARY KEY (IDCLIENTE)' + ')';

  SQLCARRO = 'CREATE TABLE CARRO (IDCARRO INTEGER NOT NULL,' +
    '  MODELO VARCHAR(50), DATALANCAMENTO DATE,' +
    '  CONSTRAINT PK_CARRO PRIMARY KEY (IDCARRO)' + ')';

  SQLVENDA = 'CREATE TABLE VENDA (IDVENDA INTEGER NOT NULL,' +
    '  IDCLIENTE INTEGER, IDCARRO INTEGER, DATAVENDA DATE,' +
    '  CONSTRAINT PK_VENDA PRIMARY KEY (IDVENDA)' + ')';

var
  qrTabelas: TFDQuery;
begin
  qrTabelas := TFDQuery.Create(nil);
  try
    qrTabelas.Connection := dmSistemaSorteio.FDConexao;

    qrTabelas.SQL.Text := SQLCLIENTE;
    try
      qrTabelas.ExecSQL;
    except
    end;

    qrTabelas.SQL.Text := SQLCARRO;
    try
      qrTabelas.ExecSQL;
    except
    end;

    qrTabelas.SQL.Text := SQLVENDA;
    try
      qrTabelas.ExecSQL;
    except
    end;

  finally
    qrTabelas.Free;
  end;
end;

end.
