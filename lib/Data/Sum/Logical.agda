open import Level.NP
open import Function
open import Type hiding (★)
open import Data.Sum.NP
open import Relation.Binary
open import Relation.Binary.Logical

module Data.Sum.Logical where

open import Data.Sum.Param.Binary public

⟦⊎⟧-refl : ∀ {a b aᵣ bᵣ}
             {A : ★ a} (Aᵣ : A → A → ★ aᵣ) (Aᵣ-refl : Reflexive Aᵣ)
             {B : ★ b} (Bᵣ : B → B → ★ bᵣ) (Bᵣ-refl : Reflexive Bᵣ)
           → Reflexive (Aᵣ ⟦⊎⟧ Bᵣ)
⟦⊎⟧-refl Aᵣ Aᵣ-refl Bᵣ Bᵣ-refl {inl x} = ⟦inl⟧ Aᵣ-refl
⟦⊎⟧-refl Aᵣ Aᵣ-refl Bᵣ Bᵣ-refl {inr y} = ⟦inr⟧ Bᵣ-refl

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
        ⟦⊎⟧-map θ ψ (⟦inl⟧ xᵣ) = ⟦inl⟧ (θ xᵣ)
        ⟦⊎⟧-map θ ψ (⟦inr⟧ xᵣ) = ⟦inr⟧ (ψ xᵣ)

    module _ {cᵣ} {Cᵣ : ⟦★⟧ cᵣ (A₁ ⊎ B₁) (A₂ ⊎ B₂)} where

        ⟦⊎⟧-[_,_] : (Aᵣ ⇒ on-inl Cᵣ) → (Bᵣ ⇒ on-inr Cᵣ) → (Aᵣ ⟦⊎⟧ Bᵣ) ⇒ Cᵣ
        ⟦⊎⟧-[ θ , ψ ] (⟦inl⟧ xᵣ) = θ xᵣ
        ⟦⊎⟧-[ θ , ψ ] (⟦inr⟧ xᵣ) = ψ xᵣ

    module _ {aᵣ′ bᵣ′}
             {Aᵣ′ : flip (⟦★⟧ aᵣ′) A₁ A₂}
             {Bᵣ′ : flip (⟦★⟧ bᵣ′) B₁ B₂}
             (θ : Sym Aᵣ Aᵣ′) -- remember Sym R S = R ⇒ flip S
             (ψ : Sym Bᵣ Bᵣ′) where
        ⟦⊎⟧-sym : Sym (Aᵣ ⟦⊎⟧ Bᵣ) (Aᵣ′ ⟦⊎⟧ Bᵣ′)
        ⟦⊎⟧-sym (⟦inl⟧ xᵣ) = ⟦inl⟧ (θ xᵣ)
        ⟦⊎⟧-sym (⟦inr⟧ xᵣ) = ⟦inr⟧ (ψ xᵣ)
        {-
        ⟦⊎⟧-sym = ⟦⊎⟧-[_,_] {Cᵣ = flip (Aᵣ′ ⟦⊎⟧ Bᵣ′)} (⟦inl⟧ ∘ θ) (⟦inr⟧ ∘ ψ)
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
⟦⊎⟧-trans A-trans B-trans (⟦inl⟧ xᵣ) (⟦inl⟧ yᵣ) = ⟦inl⟧ (A-trans xᵣ yᵣ)
⟦⊎⟧-trans A-trans B-trans (⟦inr⟧ xᵣ) (⟦inr⟧ yᵣ) = ⟦inr⟧ (B-trans xᵣ yᵣ)

⟦⊎⟧-transitive : ∀ {A : ★ _} {Aᵣ : ⟦★⟧ _ A A}
                   {B : ★ _} {Bᵣ : ⟦★⟧ _ B B}
                 → Transitive Aᵣ
                 → Transitive Bᵣ
                 → Transitive (Aᵣ ⟦⊎⟧ Bᵣ)
⟦⊎⟧-transitive = ⟦⊎⟧-trans
