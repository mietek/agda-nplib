open import Level.NP
open import Function
open import Type hiding (★)
open import Data.Sum.NP
open import Relation.Binary
open import Relation.Binary.Logical

module Data.Sum.Logical where

infixr 4 _⟦⊎⟧_

data _⟦⊎⟧_ {a₁ a₂ b₁ b₂ aᵣ bᵣ}
            {A₁ : ★ a₁} {A₂ : ★ a₂}
            (Aᵣ : A₁ → A₂ → ★ aᵣ)
            {B₁ : ★ b₁} {B₂ : ★ b₂}
            (Bᵣ : B₁ → B₂ → ★ bᵣ) : A₁ ⊎ B₁ → A₂ ⊎ B₂ → ★ (a₁ ⊔ a₂ ⊔ b₁ ⊔ b₂ ⊔ aᵣ ⊔ bᵣ) where
  ⟦inj₁⟧ : ∀ {x₁ x₂} (xᵣ : Aᵣ x₁ x₂) → (Aᵣ ⟦⊎⟧ Bᵣ) (inj₁ x₁) (inj₁ x₂)
  ⟦inj₂⟧ : ∀ {x₁ x₂} (xᵣ : Bᵣ x₁ x₂) → (Aᵣ ⟦⊎⟧ Bᵣ) (inj₂ x₁) (inj₂ x₂)

⟦[_,_]′⟧ : ∀ {a b c} →
             (∀⟨ A ∶ ⟦★⟧ a ⟩⟦→⟧ ∀⟨ B ∶ ⟦★⟧ b ⟩⟦→⟧ ∀⟨ C ∶ ⟦★⟧ c ⟩⟦→⟧
                (A ⟦→⟧ C) ⟦→⟧ (B ⟦→⟧ C) ⟦→⟧ (A ⟦⊎⟧ B) ⟦→⟧ C)
             ([_,_]′ {a} {b} {c}) ([_,_]′ {a} {b} {c})
⟦[_,_]′⟧ _ _ _ f _ (⟦inj₁⟧ xᵣ) = f xᵣ
⟦[_,_]′⟧ _ _ _ _ g (⟦inj₂⟧ xᵣ) = g xᵣ

⟦map⟧ : ∀ {a b c d} →
        (∀⟨ A ∶ ⟦★⟧ a ⟩⟦→⟧ ∀⟨ B ∶ ⟦★⟧ b ⟩⟦→⟧ ∀⟨ C ∶ ⟦★⟧ c ⟩⟦→⟧ ∀⟨ D ∶ ⟦★⟧ d ⟩⟦→⟧
            (A ⟦→⟧ C) ⟦→⟧ (B ⟦→⟧ D) ⟦→⟧ (A ⟦⊎⟧ B ⟦→⟧ C ⟦⊎⟧ D))
        (map {a} {b} {c} {d}) (map {a} {b} {c} {d})
⟦map⟧ A B C D f g = ⟦[_,_]′⟧ A B (C ⟦⊎⟧ D) (⟦inj₁⟧ ∘′ f) (⟦inj₂⟧ ∘′ g)

⟦⊎⟧-refl : ∀ {a b aᵣ bᵣ}
             {A : ★ a} (Aᵣ : A → A → ★ aᵣ) (Aᵣ-refl : Reflexive Aᵣ)
             {B : ★ b} (Bᵣ : B → B → ★ bᵣ) (Bᵣ-refl : Reflexive Bᵣ)
           → Reflexive (Aᵣ ⟦⊎⟧ Bᵣ)
⟦⊎⟧-refl Aᵣ Aᵣ-refl Bᵣ Bᵣ-refl {inj₁ x} = ⟦inj₁⟧ Aᵣ-refl
⟦⊎⟧-refl Aᵣ Aᵣ-refl Bᵣ Bᵣ-refl {inj₂ y} = ⟦inj₂⟧ Bᵣ-refl

module _ {a₁ a₂ b₁ b₂}
         {A₁ : ★ a₁} {A₂ : ★ a₂}
         {B₁ : ★ b₁} {B₂ : ★ b₂}
         {aᵣ bᵣ}
         {Aᵣ  : ⟦★⟧ aᵣ A₁ A₂}
         {Bᵣ  : ⟦★⟧ bᵣ B₁ B₂} where

    module _ {aᵣ′ bᵣ′}
             {Aᵣ′ : ⟦★⟧ aᵣ′ A₁ A₂}
             {Bᵣ′ : ⟦★⟧ bᵣ′ B₁ B₂} where

        ⟦⊎⟧-map : (Aᵣ ⇒ Aᵣ′) → (Bᵣ ⇒ Bᵣ′) → (Aᵣ ⟦⊎⟧ Bᵣ) ⇒ (Aᵣ′ ⟦⊎⟧ Bᵣ′)
        ⟦⊎⟧-map θ ψ (⟦inj₁⟧ xᵣ) = ⟦inj₁⟧ (θ xᵣ)
        ⟦⊎⟧-map θ ψ (⟦inj₂⟧ xᵣ) = ⟦inj₂⟧ (ψ xᵣ)

    module _ {cᵣ} {Cᵣ : ⟦★⟧ cᵣ (A₁ ⊎ B₁) (A₂ ⊎ B₂)} where

        ⟦⊎⟧-[_,_] : (Aᵣ ⇒ on-inj₁ Cᵣ) → (Bᵣ ⇒ on-inj₂ Cᵣ) → (Aᵣ ⟦⊎⟧ Bᵣ) ⇒ Cᵣ
        ⟦⊎⟧-[ θ , ψ ] (⟦inj₁⟧ xᵣ) = θ xᵣ
        ⟦⊎⟧-[ θ , ψ ] (⟦inj₂⟧ xᵣ) = ψ xᵣ

    module _ {aᵣ′ bᵣ′}
             {Aᵣ′ : flip (⟦★⟧ aᵣ′) A₁ A₂}
             {Bᵣ′ : flip (⟦★⟧ bᵣ′) B₁ B₂}
             (θ : Sym Aᵣ Aᵣ′) -- remember Sym R S = R ⇒ flip S
             (ψ : Sym Bᵣ Bᵣ′) where
        ⟦⊎⟧-sym : Sym (Aᵣ ⟦⊎⟧ Bᵣ) (Aᵣ′ ⟦⊎⟧ Bᵣ′)
        ⟦⊎⟧-sym (⟦inj₁⟧ xᵣ) = ⟦inj₁⟧ (θ xᵣ)
        ⟦⊎⟧-sym (⟦inj₂⟧ xᵣ) = ⟦inj₂⟧ (ψ xᵣ)
        {-
        ⟦⊎⟧-sym = ⟦⊎⟧-[_,_] {Cᵣ = flip (Aᵣ′ ⟦⊎⟧ Bᵣ′)} (⟦inj₁⟧ ∘ θ) (⟦inj₂⟧ ∘ ψ)
        -}

⟦⊎⟧-symmetric : ∀ {a b aᵣ bᵣ}
                  {A : ★ a} {Aᵣ : A → A → ★ aᵣ}
                  {B : ★ b} {Bᵣ : B → B → ★ bᵣ}
                → Symmetric Aᵣ
                → Symmetric Bᵣ
                → Symmetric (Aᵣ ⟦⊎⟧ Bᵣ)
⟦⊎⟧-symmetric = ⟦⊎⟧-sym

⟦⊎⟧-trans : ∀ {A₁ A₂ A₃} {A₁₂ : ⟦★₀⟧ A₁ A₂} {A₂₃ : ⟦★₀⟧ A₂ A₃} {A₁₃ : ⟦★₀⟧ A₁ A₃}
              {B₁ B₂ B₃} {B₁₂ : ⟦★₀⟧ B₁ B₂} {B₂₃ : ⟦★₀⟧ B₂ B₃} {B₁₃ : ⟦★₀⟧ B₁ B₃}
            → Trans A₁₂ A₂₃ A₁₃
            → Trans B₁₂ B₂₃ B₁₃
            → Trans (A₁₂ ⟦⊎⟧ B₁₂) (A₂₃ ⟦⊎⟧ B₂₃) (A₁₃ ⟦⊎⟧ B₁₃)
⟦⊎⟧-trans A-trans B-trans (⟦inj₁⟧ xᵣ) (⟦inj₁⟧ yᵣ) = ⟦inj₁⟧ (A-trans xᵣ yᵣ)
⟦⊎⟧-trans A-trans B-trans (⟦inj₂⟧ xᵣ) (⟦inj₂⟧ yᵣ) = ⟦inj₂⟧ (B-trans xᵣ yᵣ)

⟦⊎⟧-transitive : ∀ {A : ★ _} {Aᵣ : ⟦★⟧ _ A A}
                   {B : ★ _} {Bᵣ : ⟦★⟧ _ B B}
                 → Transitive Aᵣ
                 → Transitive Bᵣ
                 → Transitive (Aᵣ ⟦⊎⟧ Bᵣ)
⟦⊎⟧-transitive = ⟦⊎⟧-trans