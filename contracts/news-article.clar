;; News Article NFT Contract

(define-non-fungible-token news-article uint)

(define-map article-data uint {
    author: principal,
    title: (string-utf8 100),
    content-hash: (buff 32),
    timestamp: uint,
    stake-amount: uint
})

(define-data-var article-counter uint u0)

(define-public (create-article (title (string-utf8 100)) (content-hash (buff 32)) (stake-amount uint))
    (let
        ((article-id (+ (var-get article-counter) u1))
         (author tx-sender))
        (try! (stx-transfer? stake-amount tx-sender (as-contract tx-sender)))
        (try! (nft-mint? news-article article-id author))
        (map-set article-data article-id {
            author: author,
            title: title,
            content-hash: content-hash,
            timestamp: block-height,
            stake-amount: stake-amount
        })
        (var-set article-counter article-id)
        (ok article-id)))

(define-read-only (get-article (article-id uint))
    (ok (unwrap! (map-get? article-data article-id) (err u404))))

(define-public (transfer-article (article-id uint) (recipient principal))
    (begin
        (try! (nft-transfer? news-article article-id tx-sender recipient))
        (ok true)))

