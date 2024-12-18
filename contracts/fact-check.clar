;; Fact Check NFT Contract

(define-non-fungible-token fact-check uint)

(define-map fact-check-data uint {
    checker: principal,
    article-id: uint,
    verdict: (string-utf8 20),
    explanation: (string-utf8 500),
    timestamp: uint,
    stake-amount: uint
})

(define-data-var fact-check-counter uint u0)

(define-public (create-fact-check (article-id uint) (verdict (string-utf8 20)) (explanation (string-utf8 500)) (stake-amount uint))
    (let
        ((fact-check-id (+ (var-get fact-check-counter) u1))
         (checker tx-sender))
        (try! (stx-transfer? stake-amount tx-sender (as-contract tx-sender)))
        (try! (nft-mint? fact-check fact-check-id checker))
        (map-set fact-check-data fact-check-id {
            checker: checker,
            article-id: article-id,
            verdict: verdict,
            explanation: explanation,
            timestamp: block-height,
            stake-amount: stake-amount
        })
        (var-set fact-check-counter fact-check-id)
        (ok fact-check-id)))

(define-read-only (get-fact-check (fact-check-id uint))
    (ok (unwrap! (map-get? fact-check-data fact-check-id) (err u404))))

