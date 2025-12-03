// Academia Dia 2

// CÓDIGO DIA 1
// modelagem de PESSOA

enum NivelAluno: String {
    case iniciante
    case intermediario
    case avancado
}


class Pessoa {
    public var nome: String
    public var email: String

    init(_ nome: String, _ email: String) {
        self.nome = nome
        self.email = email
    }

    public func getDescricao() -> String {
        return "Nome: \(nome)\nEmail: \(email)"
    }

}


class Aluno: Pessoa {
    public let matricula: String
    public var nivel: NivelAluno
    private(set) var plano: Plano

    init(_ nome: String, _ email: String, _ matricula: String, _ nivel: NivelAluno, _ plano: Plano) {
        self.matricula = matricula
        self.nivel = nivel
        self.plano = plano
        super.init(nome, email)
    }

    override public func getDescricao() -> String {
        return super.getDescricao() + "\nMatrícula: \(self.matricula)\nNível: \(self.nivel.rawValue)\nPlano: \(self.plano.nome)"
    }
}


class Instrutor: Pessoa {
    public var especialidade: String  

    init(_ nome: String, _ email: String, _ especialidade: String) {
        self.especialidade = especialidade
        super.init(nome, email)
    }

    override public func getDescricao() -> String {
        return super.getDescricao() + "\nEspecialidade: \(self.especialidade)"
    }
}


// modelagem de PLANO

class Plano {  // deveria ser uma classe abstrata
    public var nome: String

    init(_ nome: String) {
        self.nome = nome
    }   

    public func calcularMensalidade() -> Double {
        return 0.0
    }
}


class PlanoMensal: Plano {
    init() {
        super.init("")  // inicializa a variável nome
        self.nome = "Plano Mensal"
    }

    override public func calcularMensalidade() -> Double {
        return 120.0
    }
}


class PlanoAnual: Plano {
    init() {
        super.init("")
        self.nome = "Plano Anual (Promocional)"
    }

    override public func calcularMensalidade() -> Double {
        return ((120.0 * 12.0) * 0.8) / 12.0
    }
}

// CÓDIGO DIA 2

protocol Manutencao {
    var nomeItem: String {get set}
    var dataUltimaManutencao: String {get}
    
    func realizarManutencao() -> Bool
}


class Aparelho: Manutencao {
    public var nomeItem: String
    private(set) var dataUltimaManutencao: String

    init(nome: String) {
        self.nomeItem = nome
        self.dataUltimaManutencao = "Nenhuma"
    }

    public func realizarManutencao() -> Bool {
        print("Data de \(self.nomeItem) atualizado para 03/12/2025")
        self.dataUltimaManutencao = "03/12/2025"

        return true
    }
}


class Aula {
    public var nome: String
    public var instrutor: Instrutor

    init(_ nome: String, _ instrutor: Instrutor) {
        self.nome = nome
        self.instrutor = instrutor
    }

    public func getDescricao() -> String {
        return "Aula \(self.nome) com o instrutor \(self.instrutor.nome)"
    }
}


class AulaPersonal: Aula {
    public var aluno: Aluno

    init(_ nome: String, _ instrutor: Instrutor, _ aluno: Aluno) {
        self.aluno = aluno
        super.init(nome, instrutor)
    }


   override public func getDescricao() -> String {
        return super.getDescricao() + " e com o aluno \(self.aluno.nome)"
   } 
}


class AulaColetiva: Aula {
    private(set) var alunosInscritos: [String: Aluno]
    public let capacidadeMaxima: Int

    init(_ nome: String, _ instrutor: Instrutor, _ capacidadeMaxima: Int) {
        self.capacidadeMaxima = capacidadeMaxima
        self.alunosInscritos = [:]  // dicionário vazio
        super.init(nome, instrutor)
    } 

    // COMENTÁRIO 2: mudamos o return para uma tupla com um status (boolean) e uma mensagem de erro, pois assim é possível identificar o erro de forma clara e ter uma mensagem específica
    public func inscrever(_ aluno: Aluno) -> (status: Bool, msg: String) {
        // se ainda houver espaço na turma
        if (self.alunosInscritos.count >= self.capacidadeMaxima) {
            // se o aluno ainda não estiver inscrito
            if (!self.alunosInscritos.keys.contains(aluno.matricula)) {
                self.alunosInscritos[aluno.matricula] = aluno
                return (status: true, msg: "Sucesso! Aluno \(aluno.nome) adicionado com sucesso!")
            } else {
                return (status: false, msg: "Erro! O aluno \(aluno.nome) já está inscrito!")
            }
        } else {
            return (status: false, msg: "Erro! Não há espaço suficiente na turma!")
        }
    }


    override public func getDescricao() -> String {
        return super.getDescricao() + ". Vagas disponíveis: (\(self.alunosInscritos.count)/\(self.capacidadeMaxima))"
    }
}