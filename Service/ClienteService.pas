unit ClienteService;

interface

uses
  ClienteDAO, Cliente, SysUtils, UDFUtils, SistemaSorteioData;

type
  TClienteService = class
  public
    procedure InserirClientesAutomaticos;
  end;

implementation

procedure TClienteService.InserirClientesAutomaticos;
var
  LIndice: Integer;
  LCliente: TCliente;
  LDAO: TClienteDAO;
begin
  LDAO := TClienteDAO.Create;
  try
    for LIndice := 1 to 5 do
    begin
      LCliente := TCliente.Create;
      try
        LCliente.IdCliente := dmSistemaSorteio.ObterMax('CLIENTE', 'IDCLIENTE') + 1;
        LCliente.Nome := 'Cliente ' + IntToStr(LCliente.IdCliente);
        LCliente.CPFCNPJ := UDFUtils.GerarCPF;
        LCliente.DataCadastro := Date;

        LDAO.Inserir(LCliente);
      finally
        LCliente.Free;
      end;
    end;
  finally
    LDAO.Free;
  end;
end;

end.
