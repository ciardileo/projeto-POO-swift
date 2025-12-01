// dia 1 de projeto (01/12)
// Leonardo Ciardi
// Lucas Bonetti
// Pedro Freitas
// Pedro Lima


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
// Comentário 1: tive que fazer uma "gambiarra" pra criar a classe plano com um inicializador, mas seria melhor se o swift aceitasse clases abstratas para que isso não fosse necessário. Por enquanto, preferi deixar assim para ter a opção de criar um plano diferente dos padrões, com Plano("Especial 1").

class Plano {  // deveria 
    public var nome: String

    init(_ nome: String) {
        self.nome = nome
    }   

    public func calcularMensalidade() -> Double {
        return 0.0
    }
}


// Para o mesmo problema, também tivemos outra solução, criando propriedades diferentes na classe filho para mudar o inicialiador:
// class Pessoa {
//     var nome: String
//     var email: String
 
//     init(nome: String, email: String) {
//         self.nome = nome
//         self.email = email
//     }
 
//     func getDescricao() -> String {
//         return ("Nome: \(nome), E-mail: \(email)") // convém a utilizar, nesta situação
//     }
 
//     enum NivelAluno {
//         case iniciante
//         case intermediario
//         case avancado
//     }
// }
 
 
// class Aluno: Pessoa {
//     var matricula: String
//     var nivel: NivelAluno
//     private (set) var plano: Plano
 
//     init(nome: String, email: String, matricula: String, nivel: NivelAluno, plano: Plano) {
//         self.matricula = matricula
//         self.nivel = .iniciante
//         super.init(nome: nome, email: email)
//     }
//     override func getDescricao() -> String {
//         return super.getDescricao() + "Matricula: \(matricula), Plano:\(plano)"
//     }
// }
 
// class Instrutor: Pessoa {
//     var especialidade: String
 
//     init(nome: String, email: String, especialidade: String) {
//         self.especialidade = especialidade
//         super.init(nome: nome, email: email)
//     }
 
//     override func getDescricao() -> String {
//         return super.getDescricao() + "Especialidade: \(especialidade)"
//     }
// }
 
 
// class Plano {
//     var nome: String
 
//     init(nome: String) {
//     self.nome = nome
//     }
//     func calcularMensalidade() -> Double {
//         return 0.0
//     }
// }
 
// class PlanoMensal: Plano {
//     var nomeDoPlano: String
//     init (nome: String, nomeDoPlano: String) {
//         self.nomeDoPlano = "Mensal"
//         super.init(nome: nome) // pega o do self e passa para o filho por causa da herança
//     }
//     override func calcularMensalidade() -> Double {
//         return 120.0
//     }
// }
 
// class PlanoAnual: Plano {
//     var nomeDoPlano: String
//    init (nome: String, nomeDoPlano: String) {
//         self.nomeDoPlano = "Anual"
// 	super.init(nome: nome)
//     }
//     override func calcularMensalidade() -> Double {
//         let valorAnualComDesconto = (120*12) - (120*12*0.2)
//         let valorMensalComDesconto = valorAnualComDesconto/12
//         return valorMensalComDesconto
//     }
// }



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


