;; Reward Distribution Contract

(define-constant contract-owner tx-sender)

(define-data-var reward-pool uint u0)

(define-public (add-to-reward-pool (amount uint))
    (begin
        (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
        (var-set reward-pool (+ (var-get reward-pool) amount))
        (ok true)))

(define-public (distribute-rewards (journalist principal) (fact-checker principal) (amount uint))
    (begin
        (asserts! (is-eq tx-sender contract-owner) (err u403))
        (asserts! (<= amount (var-get reward-pool)) (err u401))
        (try! (as-contract (stx-transfer? (/ amount u2) tx-sender journalist)))
        (try! (as-contract (stx-transfer? (/ amount u2) tx-sender fact-checker)))
        (var-set reward-pool (- (var-get reward-pool) amount))
        (ok true)))

(define-read-only (get-reward-pool)
    (ok (var-get reward-pool)))

