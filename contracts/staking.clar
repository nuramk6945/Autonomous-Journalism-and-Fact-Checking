;; Staking Contract

(define-map user-stakes principal uint)

(define-public (stake (amount uint))
    (let
        ((current-stake (default-to u0 (map-get? user-stakes tx-sender))))
        (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
        (map-set user-stakes tx-sender (+ current-stake amount))
        (ok true)))

(define-public (unstake (amount uint))
    (let
        ((current-stake (default-to u0 (map-get? user-stakes tx-sender))))
        (asserts! (>= current-stake amount) (err u401))
        (try! (as-contract (stx-transfer? amount tx-sender tx-sender)))
        (map-set user-stakes tx-sender (- current-stake amount))
        (ok true)))

(define-read-only (get-stake (user principal))
    (ok (default-to u0 (map-get? user-stakes user))))

