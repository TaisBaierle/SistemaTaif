unit ClienteDAO;

interface

uses
  Cliente, SistemaSorteioData, SysUtils;

type
  TClienteDAO = class
  public
    procedure Inserir(const ACliente: TCliente);
  end;

implementation

procedure TClienteDAO.Inserir(const ACliente: TCliente);
begin
  dmSistemaSorteio.InserirDadosBD
    ('INSERT INTO CLIENTE (IDCLIENTE, NOME, CPFCNPJ, DATACADASTRO) ' +
    'VALUES (:ID, :NOME, :CPFCNPJ, :DATA)', [ACliente.IdCliente, ACliente.Nome,
    ACliente.CPFCNPJ, Now]);
end;

end.
